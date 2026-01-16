//
//  HomeCoordinator.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 13/01/26.
//

import Foundation
import UIKit

class HomeCoordinator: Coordinator {
    private let tabItem: TabItem
    
    var parentCoordinator: (Coordinator)?
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController = UINavigationController()
    init(tabItem: TabItem) {
        self.tabItem = tabItem
    }
    
    func start() {
        // Cria a ViewModel
//        let viewModel = HomeViewModel()
        
        // Cria o ViewController e injeta a ViewModel
       let homeVC = HomeViewController()
        
        // Adiciona o ViewController à NavigationController
        navigationController.viewControllers = [homeVC]
        
        // Configura o TabBarItem usando o enum TabItem
        setTabItemStyle()
    }
    
    // Esssa função é utilizada para criar o item da tabbar e seus estilos de acordo com o valor vindo do enum de estilo
    private func setTabItemStyle() {
        let style = tabItem.style
        navigationController.tabBarItem = UITabBarItem(title: style.title, image: style.icon, selectedImage: style.selectedIcon)
    }
    
}
