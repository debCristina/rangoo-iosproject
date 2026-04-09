//
//  RecipeService.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 29/01/26.
//

import Foundation
import UIKit

class RecipeService {
    let baseURL = "https://api.spoonacular.com/recipes"
    
    //   Bundle.main significa o bundle principal do app, ou seja, o que está empacotado junto com o app.
    //O método object(forInfoDictionaryKey:) pega um valor do Info.plist do app usando a chave fornecida.
    // Converte para String.
    // Se não existir, usa string vazia.
    let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String ?? ""

    let cache = HybridCache<String, RecipeResponse>()
    

    func fetchRecipesByType(type: SectionKind, completion: @escaping (Result<[Recipe], Error>) -> Void) {
        let cacheKey = "recipes_\(type)"
        
        if let cachedData = cache.get(for: cacheKey) {
            // Cache precisa ser do tipo correto
            completion(.success(cachedData.recipes))
            print(cachedData.recipes)

            return
        }
        
        // addRecipeInformation=true garante que dishTypes venha preenchido
        let path = "/complexSearch?apiKey=\(apiKey)&type=\(type.rawQueryValue)&number=50&addRecipeInformation=true&addRecipeInstructions=true"

        guard let url = URL(string: baseURL + path) else {
            completion(.failure(NSError(domain: "InvalidURL", code: 0)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(NSError(domain: "NoData", code: 1)))
                return
            }
            
            DispatchQueue.main.async {
                do {
                    // Usa o ComplexSearchResponse correto
                    let response = try JSONDecoder().decode(ComplexSearchResponse.self, from: data)
                    print(response)
                    self.cache.set(RecipeResponse(recipes: response.results), for: cacheKey)
                    completion(.success(response.results))
                    
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
