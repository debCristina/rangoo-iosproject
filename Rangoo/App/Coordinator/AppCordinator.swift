//
//  AppCordinator.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 13/01/26.
//

import Foundation
import UIKit

// Coordinator principal do meu App
class AppCordinator: Coordinator {
    private var window: UIWindow
    
    let tabBarController = TabBarController()

    // Coordinator Pai
    var parentCoordinator: Coordinator?
    
    // Lista de coordinators filhos
    var childCoordinators: [Coordinator] = []
    
    // Navigation Controller
    var navigationController: UINavigationController
    

    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
    }
    
    func start() {
        let homeCoordinator = RecipeCoordinator(tabItem: .home)
        homeCoordinator.start()

        let listCoordinator = ListCoordinator(tabItem: .list)
        listCoordinator.start()

        childCoordinators = [homeCoordinator, listCoordinator]
        
        
        tabBarController.viewControllers = [
            homeCoordinator.navigationController,
            listCoordinator.navigationController
        ]
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
}
