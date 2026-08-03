//
//  GroceryListRepository.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 09/07/26.
//

import Foundation
import CoreData

// MARK: - Responsavel pelas operações no banco de dados
class GroceryListRepository: GroceryListRepositoryProtocol {
    private let context = PersistenceController.coreShared.context
    
    // MARK: - Busca todas as listas de compras
    func getAll() throws -> [GroceryList] {
        // Cria uma consulta de GroceryList
        let request: NSFetchRequest<GroceryList> = GroceryList.fetchRequest()
        
        // Core Data executa essa consulta no banco e retorna os objetos encontrados.
        return try context.fetch(request)
    }
    
    // MARK: - Adicionar nova lista
    func add(name: String, image: Data? = nil) throws {
        let list = GroceryList(context: context)
        list.name = name
        list.image = image
        list.totalAmount = 0.00
        
        // tenta salvar
        try save()
    }
    
    // MARK: - Salvar alterações
    func save() throws {
        // verifica se possui
        if context.hasChanges {
            // tanta salvar a alteração
            try context.save()
            
        }
    }
    
    // MARK: - Deletar lista
    func delete(list: GroceryList) throws {
        // deleta a lista
        context.delete(list)
        // salva alterações
        try context.save()
        
    }
}
