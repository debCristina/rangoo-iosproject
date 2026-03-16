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
}

struct RecipeSection {
    let section: SectionKind
    let recipes: [Recipe]
}
