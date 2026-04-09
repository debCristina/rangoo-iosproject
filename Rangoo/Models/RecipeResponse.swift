//
//  RecipeResponse.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 13/03/26.
//

import Foundation

// MARK: - Resposta esperada da API:

// MARK: - Codableé um alias de tipo para os protocolos Encodablee Decodable. Quando você usa Codablecomo um tipo ou uma restrição genérica, ele corresponde a qualquer tipo que esteja em conformidade com ambos os protocolos.
struct ComplexSearchResponse: Codable {
    let results: [Recipe]
}

// MARK: - Decodifica os dados da receita
struct Recipe: Codable {
    let id: Int
    let title: String
    let image: String
    let dishTypes: [String]?
    let readyInMinutes: Int?
    let summary: String?
    
    // MARK: - mapear os nomes das chaves do JSON para as propriedades.
    enum CodingKeys: String, CodingKey {
        case id, title, image, dishTypes, readyInMinutes, summary
    }
    
    // MARK: - Controle total de como os dados são lidos.
    init(from decoder: Decoder) throws {
        
        // Pega o JSON e organiza como um dicionário usando as CodingKeys
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        image = try container.decode(String.self, forKey: .image)
        dishTypes = try? container.decode([String].self, forKey: .dishTypes)
        summary = try? container.decode(String.self, forKey: .summary)
        
        // tolerante a Int ou String
        // Tenta ler como Int
        if let intValue = try? container.decode(Int.self, forKey: .readyInMinutes) {
            readyInMinutes = intValue
        // Se falhar tenta ler como String
        // Se for string, tenta converter para Int
        } else if let stringValue = try? container.decode(String.self, forKey: .readyInMinutes),
                  let intValue = Int(stringValue) {
            readyInMinutes = intValue
        // Se tudo falhar retorna nil
        } else {
            readyInMinutes = nil
        }
    }
}


