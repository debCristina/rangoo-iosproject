//
//  GroceryItemRepositoryProtocol.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 25/07/26.
//

import Foundation

protocol GroceryItemRepositoryProtocol {
    func getAll(list: GroceryList) throws -> [ListItem]
    func add(name: String, price: Double, quantity: Int64, unit: String, list: GroceryList) throws
    func save() throws
    func delete(item: ListItem) throws
}
