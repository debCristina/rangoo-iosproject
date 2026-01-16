//
//  TabBar.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 13/01/26.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
//        self.setupTabs()
        
        // Define a aparencia da tabBar
        let appearance = UITabBarAppearance()
        // Define a cor de funco
        appearance.backgroundColor = .white
        appearance.shadowColor = .lightGray
        appearance.stackedLayoutAppearance.selected.iconColor = .accent
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.accent]
        appearance.stackedLayoutAppearance.normal.iconColor = .lightGray
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.graySoft!]
        
        // Implementa a aparencia
        self.tabBar.standardAppearance = appearance
        self.tabBar.scrollEdgeAppearance = appearance
    }
    
//    // Criar a NavigationController de cada aba para que elas possam ser capazes de fazer suas navegações internas
//    // Definimos o título que sera adicionado a cada item da tabBar, a imagem, e a viewController.
//    private func createNav(with title: String, and image: UIImage?, selectedImage: UIImage?, vc: UIViewController) -> UINavigationController {
//        //Aqui criamos a Navigaetion Controller do item
//        let nav = UINavigationController(rootViewController: vc)
//        // Definimos o título
//        nav.tabBarItem.title = title
//        // Definimos a imagem
//        nav.tabBarItem.image = image
//        nav.tabBarItem.selectedImage = selectedImage
//        // Retornamos a navigation controller
//        return nav
//    }
//    
//    // Essa função define as caracteriticas de cada tabItem utilizando a função createNav
//    private func setupTabs() {
//        // Cria a navigationController do item
//        let home = createNav(with: "Recipes", and: UIImage(systemName:"book.pages"), selectedImage: UIImage(systemName: "book.pages.fill"), vc: HomeViewController())
//        let list = createNav(with: "List", and: UIImage(systemName:"cart"), selectedImage: UIImage(systemName: "cart.fill"), vc: ListViewController())
//
//        // Adiciona as ViewControllers dos itens na tabBar
//        self.setViewControllers([home, list], animated: true)
//    }
}

