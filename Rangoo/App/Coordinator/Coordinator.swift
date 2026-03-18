//
//  CoordinatorProtocol.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 13/01/26.
//

import Foundation
import UIKit

// Protocolo comum a todos os coordinators do projeto
protocol Coordinator: AnyObject {
    // Coordinator pai opcional para caso o Coordinator se gerencia
    var parentCoordinator: Coordinator? {get set}
    // Coordinators filhos para fluxos
    var childCoordinators: [Coordinator] {get set}
    
    // Navigation Controller para gerenciar as apresentações
    var navigationController: UINavigationController { get set }
    
    // Método para caso um fluxo filho seja finalizado
    func childDidFinish(_ child: Coordinator?)
    
    // Start fluxo
    func start()
}

// Extensão para a implementação padrão do método de finish
extension Coordinator {
    // Funcao recebe o coordinator filho responsavel por finalizar suas funções
    func childDidFinish(_ child: Coordinator?) {
        // Remove o fluxo da lista de filhos do coordinator pai
        if let index = childCoordinators.firstIndex(where: { $0 === child }) {
            childCoordinators.remove(at: index)
        }
    }
}
