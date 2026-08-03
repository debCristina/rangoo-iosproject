//
//  ListCoordinatorProtocol.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 06/05/26.
//

import Foundation

// MARK: - Protocolo utilizado pelo coordinator de lista de compras e pela view model para garantir o desaclopamento
protocol ListCoordinatorProtocol: AnyObject {
    
    func goToGroceryListDetail(list: GroceryList)
    func navigateToList()
    func presentItemDetailModal(list: GroceryList)
    func presentListAddModal()
    func presentListEditModal(list: GroceryList)
    func presentEditItemModal(item: ListItem, list: GroceryList)
}
