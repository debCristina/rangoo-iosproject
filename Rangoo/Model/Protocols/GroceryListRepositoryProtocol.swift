//
//  GroceryListRepository.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 09/07/26.
//

import Foundation

protocol GroceryListRepositoryProtocol {
    func getAll() throws -> [GroceryList]
    func add(name: String, image: Data?) throws
    func save() throws
    func delete(list: GroceryList) throws
}
