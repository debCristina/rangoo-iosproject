//
//  GroceryListDetailViewModel.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 06/05/26.
//

import Foundation

class GroceryListDetailViewModel {
    weak var coordinator: ListCoordinatorProtocol?
    private var groceryItemRepository: GroceryItemRepositoryProtocol
    let list: GroceryList
    var allItems: [ListItem] = []
    
    var total: Double {
        allItems.reduce(0) { $0 + ($1.price * Double($1.quantity)) }
    }
    
    init(list: GroceryList, coordinator: ListCoordinatorProtocol? = nil,  groceryItemRepository: GroceryItemRepositoryProtocol) {
        
        self.list = list
        self.coordinator = coordinator
        self.groceryItemRepository = groceryItemRepository
        
    }
    
    // MARK: - Carrega os itens da lista
    func loadData() throws {
        self.allItems = try groceryItemRepository.getAll(list: list)
    }
    
    func addItemToList(name: String, price: Double, quantity: Int64, unit: String, list: GroceryList) throws {
        try groceryItemRepository.add(name: name, price: price, quantity: quantity, unit: unit, list: list)
        
        try loadData()
        
    }
    
    func didSelectItem(item: ListItem) {
        coordinator?.presentEditItemModal(item: item, list: list)
    }
    
    func presentAddItem() {
        coordinator?.presentItemDetailModal(list: list)
    }
    
    
    
    func editItem(item: ListItem, name: String, price: Double, quantity: Int64, unit: String) throws {
        item.name = name
        item.price = price
        item.quantity = quantity
        item.unit = unit
        
        try groceryItemRepository.save()
        try loadData()
    }
    
    func deleteItem(item: ListItem) throws {
        try groceryItemRepository.delete(item: item)
        try loadData()

    }
    
    
}
