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
    let APIKey = "60e8592d6dd94900aecffc7e323e601d"
    
    private let cache = HybridCache<String, RecipeResponse>()
    
    func fetchRandomRecipes(completion: @escaping (Result<RecipeResponse, Error>) -> Void) {
        let cacheKey = "randomRecipes"

        // Tenta buscar no cache antes de ir para a API
        if let cachedData = cache.get(for: cacheKey) {
            completion(.success(cachedData))
            return
        }
        // Se não tiver no cache monta a url
        let path = "/random?apiKey=\(APIKey)&number=30"
        guard let url = URL(string: baseURL + path) else {
            completion(.failure(NSError(domain: "InvalidURL", code: 0)))
            return
        }
        let session = URLSession.shared

        // Armazenar a sessão da request e retorna a dado da corpo da requisição, o responde que é o objeto e o erro
        let task = session.dataTask(with: url) { data, response , error in
            guard let data = data else {
                completion(.failure(NSError(domain: "NoData", code: 1)))
                return
            }
            
            DispatchQueue.main.async {
                do {
                    let recipes = try JSONDecoder().decode(RecipeResponse.self, from: data)
//                    self.cache.set(recipes, for: cacheKey)
                    completion(.success(recipes))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }
}

