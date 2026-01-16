//
//  TabItens.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 14/01/26.
//

import Foundation
import UIKit

struct TabItemStyle {
    let title: String
    let icon: UIImage?
    let selectedIcon: UIImage?
}

enum TabItem {
    case home
    case list
    
    // Variavel que recebe um valor de acordo com o que foi passado para ela
    var style: TabItemStyle {
        // Percorre dentro do proprio enum se o caso é de acordo
        switch self {
            // Caso o item for o Home retorna o estilo do item home
            case .home:
                return TabItemStyle(title: "Recipes", icon: UIImage(systemName: "book.pages"), selectedIcon: UIImage(systemName: "book.pages.fill"))
                    
            // Caso o item for list retorna o estilo do item list
            case .list:
                return TabItemStyle(title: "List", icon: UIImage(systemName: "list.bullet.rectangle.portrait"), selectedIcon: UIImage(systemName: "list.bullet.rectangle.portrait.fill"))
        }
    }
}
