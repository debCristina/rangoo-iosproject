//
//  GroceryListViewModel.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 05/05/26.
//

import Foundation

// MARK: - View Model responsavel pela transmissão de dados
class GroceryListViewModel {
    // Referencia ao protocolo do coordinator
    weak var coordinator: ListCoordinatorProtocol?
    var allLists: [GroceryList] = []
    private var groceryListRepository: GroceryListRepositoryProtocol
    
    init(coordinator: ListCoordinatorProtocol? = nil,  groceryListRepository: GroceryListRepositoryProtocol) {
        self.coordinator = coordinator
        self.groceryListRepository = groceryListRepository
    }
    
    // MARK: - Carrega as listas
    func loadData() throws {
        self.allLists = try groceryListRepository.getAll()
        
    }
    
    // MARK: - TODO: Validações
    func addList(name: String, image: Data? = nil) throws {
        
        try groceryListRepository.add(name: name, image: image)
        
        try loadData()
    }
    
    func goToListDetailView(list: GroceryList) {
        coordinator?.goToGroceryListDetail(list: list)
    }
    
    // MARK: - Deletar lista
    func deleteList(list: GroceryList) throws{
        try groceryListRepository.delete(list: list)
        try loadData()

    }
    
    func presenteAddModal() {
        coordinator?.presentListAddModal()
    }
    
    func presentEditModal(list: GroceryList) {
        coordinator?.presentListEditModal(list: list)
    }
    
    func editList(list: GroceryList, name: String) throws {
        list.name = name
        try groceryListRepository.save()
        try loadData()
    }
    
    
}
