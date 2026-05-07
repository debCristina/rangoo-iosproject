//
//  RecipeDetailViewModel.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 21/04/26.
//

import Foundation


// MARK: - View model responsavel pelas tramissões de dados
class RecipeDetailViewModel {
    
    // MARK: - Variaveis de configuração
    
    // Estado que a ui pode assumir
    enum State {
        case ingredients
        case instructions
    }
    
    // Receita recebida para exibir detalhes
    let recipe: Recipe
    
    // MARK: - Método de inicialização
    init(recipe: Recipe) {
        self.recipe = recipe
    }
}
