//
//  RecipeResponse.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 13/03/26.
//

import Foundation

// Resposta esperada da API:

//Codableé um alias de tipo para os protocolos Encodablee Decodable. Quando você usa Codablecomo um tipo ou uma restrição genérica, ele corresponde a qualquer tipo que esteja em conformidade com ambos os protocolos.
struct RecipeResponse: Codable {
    let recipes: [Recipe]
}

struct Recipe: Codable {
    let id: Int
    let title: String
    let image: String
    let dishTypes: [String]?
    let readyInMinutes: Int?
    let summary: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title, image, dishTypes, readyInMinutes, summary
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        image = try container.decode(String.self, forKey: .image)
        dishTypes = try? container.decode([String].self, forKey: .dishTypes)
        summary = try? container.decode(String.self, forKey: .summary)
        
        // tolerante a Int ou String
        if let intValue = try? container.decode(Int.self, forKey: .readyInMinutes) {
            readyInMinutes = intValue
        } else if let stringValue = try? container.decode(String.self, forKey: .readyInMinutes),
                  let intValue = Int(stringValue) {
            readyInMinutes = intValue
        } else {
            readyInMinutes = nil
        }
    }
}

struct ComplexSearchResponse: Codable {
    let results: [Recipe]
}
