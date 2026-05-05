//
//  HomeCoordinator.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 13/01/26.
//

import Foundation
import UIKit

class ListCoordinator: Coordinator {
    private let tabItem: TabItem
    
    var parentCoordinator: (Coordinator)?
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController = UINavigationController()
    init(tabItem: TabItem) {
        self.tabItem = tabItem
    }
    
    
    func start() {
        // Cria a ViewModel
        // let viewModel = HomeViewModel()
        let viewModel = GroceryListViewModel()

        // Cria o ViewController e injeta a ViewModel
        let homeVC = ListViewController(viewModel: viewModel)
        
        // Adiciona o ViewController à NavigationController
        navigationController.viewControllers = [homeVC]
        
        // Configura o TabBarItem usando o enum TabItem
        navigationController.tabBarItem = tabItem.makeTabBarItem()

    }
    
    
    
    
}
