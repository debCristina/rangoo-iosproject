//
//  RecipeDetailViewModel.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 21/04/26.
//

import Foundation

class RecipeDetailViewModel {
    
    enum State {
        case ingredients
        case instructions
    }
    
    var state: State = .ingredients
}
