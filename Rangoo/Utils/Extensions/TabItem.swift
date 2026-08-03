//
//  TabItem.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 17/03/26.
//

import Foundation
import UIKit

// MARK: - Configura o tab item da tab bar
extension TabItem {
    // MARK: - Cria o item a tab bar conteudo dinamico
    func makeTabBarItem() -> UITabBarItem {
        // MARK: - Configura o estilo
        let style = self.style
        return UITabBarItem(
            title: style.title,
            image: style.icon,
            selectedImage: style.selectedIcon
        )
    }
}
