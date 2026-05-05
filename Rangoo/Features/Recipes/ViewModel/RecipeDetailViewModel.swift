//
//  RecipeDetailViewModel.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 21/04/26.
//

import Foundation

import Foundation

class RecipeDetailViewModel {
    
    enum State {
        case ingredients
        case instructions
    }
    
    let recipe: Recipe
    var state: State = .ingredients
    
    init(recipe: Recipe) {
        self.recipe = recipe
    }
}
