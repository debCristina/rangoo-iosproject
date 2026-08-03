//
//  HomeCoordinator.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 13/01/26.
//

import Foundation
import UIKit

// MARK: - Coordinator responsável pelo fluxo de telas da lista de compras
class ListCoordinator: Coordinator, ListCoordinatorProtocol {
    
    
    
    // MARK: - Variaveis de configurações
    
    // Define o item da lista
    private let tabItem: TabItem
    
    // Coordinator pai
    var parentCoordinator: (Coordinator)?
    
    // Coordinators filhos
    var childCoordinators: [Coordinator] = []
    
    // Define a navigation controller
    var navigationController = UINavigationController()
    
    private weak var listViewController: ListViewController?
    private weak var groceryListDetailViewController: GroceryListDetailViewController?
    
    private let groceryListRepository: GroceryListRepositoryProtocol
    private let groceryItemRepository: GroceryItemRepositoryProtocol
    
    init(
        tabItem: TabItem,
        groceryListRepository: GroceryListRepositoryProtocol = GroceryListRepository(),
        groceryItemRepository: GroceryItemRepositoryProtocol = GroceryItemRepository()
    ) {
        self.tabItem = tabItem
        self.groceryListRepository = groceryListRepository
        self.groceryItemRepository = groceryItemRepository
    }
    
    // MARK: - Inicia o fluxo de telas da lista de compras
    func start() {
        
        // Configura o TabBarItem usando o enum TabItem
        navigationController.tabBarItem = tabItem.makeTabBarItem()
        navigateToList()
    }
    
    // MARK: - Inciacia o fluxo de listas
    func navigateToList() {
        // Cria o Repository e ViewModel
        let viewModel = GroceryListViewModel(
            groceryListRepository: groceryListRepository
        )
        
        // Define o coordinator da view model como o list coordinator
        viewModel.coordinator = self
        
        // Cria o ViewController e injeta a ViewModel
        let listVC = ListViewController(viewModel: viewModel)
        
        self.listViewController = listVC
        // Adiciona o ViewController à NavigationController
        navigationController.viewControllers = [listVC]
        
    }
    
    func goToGroceryListDetail(list: GroceryList) {
        
        let viewModel = GroceryListDetailViewModel(list: list, groceryItemRepository: groceryItemRepository)
        
        // Cria o ViewController e injeta a ViewModel
        let groceryListDetailViewController = GroceryListDetailViewController(viewModel: viewModel)
        self.groceryListDetailViewController = groceryListDetailViewController
        viewModel.coordinator = self
        
        // Adiciona o ViewController à NavigationController
        navigationController.pushViewController(groceryListDetailViewController, animated: false)
    }
    
    func presentItemDetailModal(list: GroceryList) {
        
        let viewModel = GroceryListDetailViewModel(list: list, groceryItemRepository: groceryItemRepository)
        
        // Cria o ViewController
        let itemDetailViewController = ItemDetailModalViewController(viewModel: viewModel, mode: .create, list: list)
        
        // Define o estilo de apresentação do modal
        itemDetailViewController.modalPresentationStyle = .pageSheet
        
        // define um sheet para configuração de propriedades
        if let sheet = itemDetailViewController.sheetPresentationController {
            // sheet medio
            sheet.detents = [(.medium())]
            
            // indicador visivel
            sheet.prefersGrabberVisible = true
            
            // garante que o modal nao se expanda
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
        }
        
        itemDetailViewController.onItemAdded = { [weak self] in
            self?.groceryListDetailViewController?.refreshList()
        }
        
        let nav = UINavigationController(
            
            rootViewController: itemDetailViewController
            
        )
        
        // apresenta a view controller
        navigationController.present(nav, animated: true )
    }
    
    func presentListAddModal() {
        let repository = GroceryListRepository()
        let viewModel = GroceryListViewModel(groceryListRepository: repository)
        let addModalViewController = AddListModalViewController(viewModel: viewModel, mode: .create)
        
        addModalViewController.modalPresentationStyle = .pageSheet
        
        if let sheet = addModalViewController.sheetPresentationController {
            sheet.detents = [(.medium())]
            sheet.prefersGrabberVisible = true
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
        }
        
        let nav = UINavigationController(rootViewController: addModalViewController)
        
        addModalViewController.onListAdded = { [weak self] in
            self?.listViewController?.refreshList()
        }
        
        navigationController.present(nav, animated: true)
    }
    
    func presentListEditModal(list: GroceryList) {
        let repository = GroceryListRepository()
        let viewModel = GroceryListViewModel(groceryListRepository: repository)
        
        let addModalViewController = AddListModalViewController(
            viewModel: viewModel,
            mode: .edit(list: list)
        )
        
        addModalViewController.modalPresentationStyle = .pageSheet
        
        if let sheet = addModalViewController.sheetPresentationController {
            sheet.detents = [(.medium())]
            sheet.prefersGrabberVisible = true
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
        }
        
        let nav = UINavigationController(rootViewController: addModalViewController)
        
        addModalViewController.onListAdded = { [weak self] in
            self?.listViewController?.refreshList()
        }
        
        navigationController.present(nav, animated: true)
    }
    
    func presentEditItemModal(item: ListItem, list: GroceryList) {
        let viewModel = GroceryListDetailViewModel(
            list: list,
            groceryItemRepository: groceryItemRepository
        )
        
        let itemDetailViewController = ItemDetailModalViewController(
            viewModel: viewModel,
            mode: .edit(item: item), list: list
        )
        
        itemDetailViewController.modalPresentationStyle = .pageSheet
        
        if let sheet = itemDetailViewController.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
        }
        
        itemDetailViewController.onItemAdded = { [weak self] in
            self?.groceryListDetailViewController?.refreshList()
        }
        
        let nav = UINavigationController(rootViewController: itemDetailViewController)
        
        navigationController.present(nav, animated: true)
    }
}
