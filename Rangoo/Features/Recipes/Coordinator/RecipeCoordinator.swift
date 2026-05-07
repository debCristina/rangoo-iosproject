//
//  HomeCoordinator.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 13/01/26.
//

import Foundation
import UIKit

// MARK: - Recipe Coordinator: Responsável pelos fluxos de receita
class RecipeCoordinator: Coordinator, RecipeCoordinatorProtocol {
    
    // MARK: - Coniguração de variáveis
    // Configuracao da tab item
    private let tabItem: TabItem
    
    // Configuração do coordinator pai
    var parentCoordinator: (Coordinator)?
    
    // Lista de coordinators filhos
    var childCoordinators: [Coordinator] = []
    
    // Cria a navigation controller
    var navigationController = UINavigationController()
    
    // MARK: - Função de inicialização
    init(tabItem: TabItem) {
        self.tabItem = tabItem
    }
    
    // MARK: - Função que inicia o fluxo
    func start() {
        // Configura o TabBarItem usando o enum TabItem
        navigationController.tabBarItem = tabItem.makeTabBarItem()
        // Chama a primeira tela
        navigateToRecipes()
    }
    
    // MARK: - Função de navegar para a tela de receita
    func navigateToRecipes() {
        // cria o serviço
        let service = RecipeService.shared
        
        // Cria a ViewModel
        let viewModel = RecipesViewModel(recipeService: service)
        viewModel.coordinator = self
        // Cria o ViewController e injeta a ViewModel
        let recipeVC = RecipesViewController(viewModel: viewModel)
        
        // Adiciona o ViewController à NavigationController
        navigationController.viewControllers = [recipeVC]
    }
    
    // MARK: - Função de navegar para a tela que lista receitas por uma categoria
    func navigateToRecipeList(category: SectionKind, recipes: [Recipe]) {
        // Cria a ViewModel
        let listViewModel = RecipeByCategoryViewModel(category: category, recipes: recipes)
        
        // Cria a ViewCAontroller
        let listVC = ListCategoryViewController(viewModel: listViewModel)
        
        // Define o coordinator pai como recipeCoordinator
        listViewModel.coordinator = self
        
        // Chama a proxima tela
        navigationController.pushViewController(listVC, animated: false)
    }
    
    // MARK: - Função responsavel por exibir a tela de detalhes da receita
    func navigateToRecipeDetail(recipe: Recipe) {
        // Define a view model
        let detailViewModel = RecipeDetailViewModel(recipe: recipe)
        // Define a view controller
        let detailVC = RecipeDetailViewController(viewModel: detailViewModel)
        
        // Chama a tels de detalhes
        navigationController.pushViewController(detailVC, animated: false)
    }
}
