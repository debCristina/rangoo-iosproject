//
//  RecipeService.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 29/01/26.
//

import Foundation
import UIKit

// MARK: - Classe responsavel pela requisicao de receitas
class RecipeService {
    static let shared = RecipeService()

    // MARK: - Configuracao das variaveis
    
    // cria a url base
    let baseURL = "https://api.spoonacular.com/recipes"
    
    //  Bundle.main significa o bundle principal do app, ou seja, o que está empacotado junto com o app.
    //O método object(forInfoDictionaryKey:) pega um valor do Info.plist do app usando a chave fornecida.
    // Converte para String.
    // Se não existir, usa string vazia.
    let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String ?? ""
    
    // Cria uma instancia de cache
    let cache = HybridCache<String, ComplexSearchResponse>()
    
    // MARK: - Buscar receitas com base na categoria
    func fetchRecipesByType(type: SectionKind, completion: @escaping (Result<[Recipe], Error>) -> Void) {
        
        let path = "/complexSearch?apiKey=\(apiKey)&type=\(type.rawQueryValue)&number=50&addRecipeInformation=true&addRecipeInstructions=true  &fillIngredients=true"
        
        guard let url = URL(string: baseURL + path) else {
            completion(.failure(NSError(domain: "InvalidURL", code: 0)))
            return
        }
        
        // Usa a URL como chave — qualquer mudança nos params invalida o cache
        let cacheKey = "recipes_\(type.rawQueryValue)"

      
        if let cachedData = cache.get(for: cacheKey) {
            print("CACHE HIT:", cacheKey)
            completion(.success(cachedData.results))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(NSError(domain: "NoData", code: 1)))
                return
            }
            
            DispatchQueue.main.async {
                do {
                    let response = try JSONDecoder().decode(ComplexSearchResponse.self, from: data)
                    
                    self.cache.set(ComplexSearchResponse(results: response.results), for: cacheKey)
                    completion(.success(response.results))
                    
                } catch {
                    print("Erro no decode: \(error)")
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
