//
//  HomeCoordinatorProtocol.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 07/04/26.
//

import Foundation

// MARK: - Protocolo utilizado pelo coordinator de receitas e pela view model para garantir o desaclopamento
protocol RecipeCoordinatorProtocol: AnyObject {
    
    // Método de navegar para a próxima tela com a categoria e com a lista de receitas
    func navigateToRecipeList(category: SectionKind, recipes: [Recipe])
    
    func navigateToRecipeDetail(recipe: Recipe)
}
