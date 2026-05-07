//
//  HomeCoordinator.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 13/01/26.
//

import Foundation
import UIKit

// MARK: - Coordinator responsável pelo fluxo de telas da lista de compras
class ListCoordinator: Coordinator, ListCoordinatorProtocol {
    // MARK: - Variaveis de configurações
    
    // Define o item da lista
    private let tabItem: TabItem
    
    // Coordinator pai
    var parentCoordinator: (Coordinator)?
    
    // Coordinators filhos
    var childCoordinators: [Coordinator] = []
    
    // Define a navigation controller
    var navigationController = UINavigationController()
    
    // MARK: - Métodos de inicialização
    init(tabItem: TabItem) {
        self.tabItem = tabItem
    }
    
    // MARK: - Inicia o fluxo de telas da lista de compras
    func start() {
        
        // Configura o TabBarItem usando o enum TabItem
        navigationController.tabBarItem = tabItem.makeTabBarItem()
        navigateToList()
    }
    
    // MARK: - Inciacia o fluxo de listas
    func navigateToList() {
        // Cria a ViewModel
        let viewModel = GroceryListViewModel()
        
        // Define o coordinator da view model como o list coordinator
        viewModel.coordinator = self
        
        // Cria o ViewController e injeta a ViewModel
        let listVC = ListViewController(viewModel: viewModel)
        
        // Adiciona o ViewController à NavigationController
        navigationController.viewControllers = [listVC]
        
    }
    
    func goToGroceryListDetail() {
        
        // Cria o ViewController e injeta a ViewModel
        let groceryListDetailViewController = GroceryListDetailViewController()
        
        // Adiciona o ViewController à NavigationController
        navigationController.pushViewController(groceryListDetailViewController, animated: false)
    }
    
}
