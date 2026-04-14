//
//  RecipeByCategoryViewModel.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 06/04/26.
//

import Foundation

// MARK: - View model responsavel pela lista de receitas da categoria
class RecipeByCategoryViewModel {
    // MARK: - Configuracao de variavel
    // categoria da sessao
    let category: SectionKind
    // Já chega populado, sem precisar de nova requisição
    let recipes: [Recipe]
    
    weak var coordinator: RecipeCoordinatorProtocol?
    
    // MARK: - Incia a view model
    init(category: SectionKind, recipes: [Recipe]) {
        self.category = category
        self.recipes = recipes
    }
    
    func goToRecipeDetail() {
        coordinator?.navigateToRecipeDetail()
    }

}
