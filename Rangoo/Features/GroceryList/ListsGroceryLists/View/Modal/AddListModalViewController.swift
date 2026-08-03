//
//  AddListModalViewController.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 10/07/26.
//

import Foundation
import UIKit

enum ListModalType: Equatable {
    case create
    case edit(list: GroceryList)
}

class AddListModalViewController: UIViewController {
    private let viewModel: GroceryListViewModel
    private let mode: ListModalType
    private let addModalView = AddListModalView()
    var onListAdded: (() -> Void)?

    init(viewModel: GroceryListViewModel, mode: ListModalType) {
        self.viewModel = viewModel
        self.mode = mode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupEditData()
        view = addModalView
        view.backgroundColor = .white
    }
    
    private func setupEditData() {
        guard case .edit(let list) = mode else { return }
        
        addModalView.listName = list.name ?? ""
    }
    
    // MARK: - Confugura a navegação
    private func setupNavigation() {
        // Define o título da navegação

        switch mode {
        case .create:
            title = "Adicionar Lista"
            
        case .edit:
            title = "Editar Lista"
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
    
   
    
    @objc private func didTapSave() {
        do {
            switch mode {
            case .create:
                try viewModel.addList(
                    name: addModalView.listName,
                    image: nil
                )
                
            case .edit(let list):
                let newName = addModalView.listName
                
                guard !newName.isEmpty else {
                    return
                }
                
                guard newName != list.name else {
                    dismiss(animated: true)
                    return
                }
                
                try viewModel.editList(
                    list: list,
                    name: newName
                )
            }
            onListAdded?()
            dismiss(animated: true)
            
        } catch {
            print(error)
        }
    }
}
