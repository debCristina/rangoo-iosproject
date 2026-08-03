//
//  ItemDetailModalViewController.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 13/05/26.
//

import Foundation
import UIKit

enum ListDetailType: Equatable {
    case create
    case edit(item: ListItem)
}

class ItemDetailModalViewController: UIViewController {
    let itemDetailView = ItemDetailModalView()
    private let viewModel: GroceryListDetailViewModel
    private let mode: ListDetailType
    private let list: GroceryList
    var onItemAdded: (() -> Void)?

    init(
        viewModel: GroceryListDetailViewModel, mode: ListDetailType,
        list: GroceryList
    ) {
        self.viewModel = viewModel
        self.mode = mode
        self.list = list
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Função que executa quando a view carregar
    override func viewDidLoad() {
        view = itemDetailView
        setupNavigation()
        
        if case let .edit(item) = mode {
            itemDetailView.configure(with: item)
        }
        
    }
    
    
    // MARK: - Confugura a navegação
    private func setupNavigation() {
        // Define o título da navegação
        switch mode {
        case .create :
            title = "Adicionar item"
        case .edit:
            title = "Editar item"
        }
        

        // Ativa o titulo maior
        navigationController?.navigationBar.prefersLargeTitles = false
        
        // Configura a fonte do título
        let font = UIFont.customFont(type: .semiBold, size: 20)
        // Adiciona os atributos como cor e fonte do titulo
//        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.black, .font: font]
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black, .font: font]

        
        let cancelButton = UIBarButtonItem(
            title: "Cancel",
            style: .plain,
            target: self,
            action: nil
        )
        
        cancelButton.setTitleTextAttributes([
            .font: UIFont.customFont(type: .semiBold, size: 18),
                .foregroundColor: UIColor.systemGray
        ], for: .normal)
        
        let saveButton = UIBarButtonItem(
            title: mode == .create ? "Save" : "Done",
            style: .plain,
            target: self,
            action: #selector(didTapSave)
        )
        
        cancelButton.setTitleTextAttributes([
            .font: UIFont.customFont(type: .semiBold, size: 18),
            .foregroundColor: UIColor.systemGray
        ], for: .normal)
        
        saveButton.setTitleTextAttributes([
            .font: UIFont.customFont(type: .semiBold, size: 18),
            .foregroundColor: UIColor.accent
        ], for: .normal)
        

        
        navigationItem.rightBarButtonItem = saveButton
        navigationItem.leftBarButtonItem = cancelButton
        
        navigationItem.leftBarButtonItem?.tintColor = .softGray
    }
    
    @objc
    private func didTapSave() {
        let data = itemDetailView.getItemData()
        
        do {
            switch mode{
            case .create:
                
                try viewModel.addItemToList(
                    name: data.name,
                    price: data.price,
                    quantity: Int64(data.quantity),
                    unit: data.unit,
                    list: list
                )
            case .edit(item: let item):
                guard !data.name.isEmpty else {
                    return
                }
                
                try viewModel.editItem(
                    item: item,
                    name: data.name,
                    price: data.price,
                    quantity: Int64(data.quantity),
                    unit: data.unit
                )
            }
            onItemAdded?()
            dismiss(animated: true)
        } catch {
            print(error)
        }
    }
    
}
