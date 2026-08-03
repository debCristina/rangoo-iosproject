//
//  CoreDataPersistenceController.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 19/06/26.
//

import Foundation
import CoreData

// MARK: - Container do core data
// Útil para remover configurações de banco de dados do app delegate
class PersistenceController {
    // MARK: - Configurações
    // Singleton do controller para possuir apenas um ponto de acesso ao banco
    static var coreShared = PersistenceController()
    // Container do banco de dados
    let container: NSPersistentContainer
    
    var context: NSManagedObjectContext {
        container.viewContext
    }
    // MARK: - Inicialização da classe
    private init() {
        // Container com a informação do data modeld
        self.container = NSPersistentContainer(name: "Rangoo")
        // Tenta carregar o banco
        container.loadPersistentStores(completionHandler: {
            (storeDescription, error) in
            if let error = error  {
                fatalError("Erro ao carregar o banco de dados  \(error)")
            } 
        })
    }
    
    // MARK: - Salvar o contexto
    func saveContext() throws {
        // verifica se houve mudanças
        guard context.hasChanges else { return }
        
        // tenta salvar
        try context.save()
    }
    
    
    
    
    
    
    
}
