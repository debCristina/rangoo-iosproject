//
//  TabItem.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 17/03/26.
//

import Foundation
import UIKit

extension TabItem {
    func makeTabBarItem() -> UITabBarItem {
        let style = self.style
        return UITabBarItem(
            title: style.title,
            image: style.icon,
            selectedImage: style.selectedIcon
        )
    }
}
