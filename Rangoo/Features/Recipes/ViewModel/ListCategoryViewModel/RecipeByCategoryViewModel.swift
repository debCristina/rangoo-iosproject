//
//  RecipeByCategoryViewModel.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 06/04/26.
//

import Foundation

class RecipeByCategoryViewModel {
    let category: SectionKind
    // Já chega populado, sem precisar de nova requisição
    let recipes: [Recipe]
    
    init(category: SectionKind, recipes: [Recipe]) {
        self.category = category
        self.recipes = recipes
    }
}
