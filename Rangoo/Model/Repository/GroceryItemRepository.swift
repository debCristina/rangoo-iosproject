//
//  GroceryItemRepository.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 25/07/26.
//

import Foundation
import CoreData

class GroceryItemRepository: GroceryItemRepositoryProtocol {
    private let context = PersistenceController.coreShared.context

    func getAll(list: GroceryList) throws -> [ListItem] {
        // Cria uma consulta de GroceryList
        let request: NSFetchRequest<ListItem> = ListItem.fetchRequest()
        // Busca pela lista ao qual o item pertence
        request.predicate = NSPredicate(format: "groceryList == %@", list)
        // Modo de listagem dos itens
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        // Core Data executa essa consulta no banco e retorna os objetos encontrados.
        return try context.fetch(request)
    }

    func add(name: String, price: Double, quantity: Int64, unit: String, list: GroceryList) throws {
        let item = ListItem(context: context)
        item.name = name
        item.price = price
        item.quantity = quantity
        item.unit = unit
        item.groceryList = list
        
        try save()
        
    }
    
    func save() throws {
        // verifica se possui
        if context.hasChanges {
            // tanta salvar a alteração
            try context.save()
            
        }
    }
    
    func delete(item: ListItem) throws {
        // deleta a lista
        context.delete(item)
        // salva alterações
        try context.save()
    }
    
}
