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
    
    func goToListDetailView() {
        coordinator?.goToGroceryListDetail()
    }
    
    func deleteList() {
        print("deletei")
    }
    
    func editList() {
        print("editei")
    }
}
