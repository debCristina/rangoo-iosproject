//
//  GroceryListDetailViewController.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 06/05/26.
//

import Foundation
import UIKit

// MARK: - Controller da tela de detalhes
class GroceryListDetailViewController: UIViewController {
    // MARK: - Variaveis de configuração
    
    // View de detalhes
    let groceryListDetailView = GroceryListDetailView()
    let viewModel: GroceryListDetailViewModel
    
    
    // MARK: - Inicializacao da classe com a sua respectiva view model
    init(viewModel: GroceryListDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Função que executa quando a view carregar
    override func viewDidLoad() {
        view.backgroundColor = UIColor.systemBlue
        setupNavigation()
        view.backgroundColor = .white
        view = groceryListDetailView
        groceryListDetailView.groceryItemstableView.dataSource = self
        groceryListDetailView.groceryItemstableView.delegate = self
        
        groceryListDetailView.header.configure(
            with: viewModel.list,
            total: viewModel.total
        )
        refreshList()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshList()
    }
    
    // MARK: - Confugura a navegação
    private func setupNavigation() {
        // Define o título da navegação
        title = viewModel.list.name
        // Ativa o titulo maior
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Configura a fonte do título
        let font = UIFont.customFont(type: .semiBold, size: 30)
        // Adiciona os atributos como cor e fonte do titulo
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.black, .font: font]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(   barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
    }
    
    func refreshList() {
        loadData()
    }
    
    func loadData() {
        do {
            try viewModel.loadData()
            
            groceryListDetailView.header.configure(
                with: viewModel.list,
                total: viewModel.total
            )
            groceryListDetailView.groceryItemstableView.reloadData()
            
        } catch {
            print(error)
        }
    }
    
    // MARK: - Ação do botão da toolbar
    @objc private func didTapAdd() {
        
        viewModel.presentAddItem()
    }
}

// MARK: - Data source da table view
extension GroceryListDetailViewController: UITableViewDataSource {
    // MARK: - Define o número de linhas
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.allItems.count
    }
    
    // MARK: - Define a celula a ser exibida
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: GroceryDetailTableViewCell.identifier,
            for: indexPath
        ) as? GroceryDetailTableViewCell else {
            return UITableViewCell()
        }
        
        let item = viewModel.allItems[indexPath.row]
        cell.configure(with: item)
        
        return cell
    }
}

extension GroceryListDetailViewController: UITableViewDelegate {
    // MARK: - Detecta clique na celula
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Chama o coordinator para navegar
        let item = viewModel.allItems[indexPath.row]
        
        viewModel.didSelectItem(item: item)
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, completion in
            
           
            
            do {
                // chama a função da view model
                guard let item = self?.viewModel.allItems[indexPath.row] else { return }
                try self?.viewModel.deleteItem(item: item)
                self?.loadData()
                completion(true)
                
            } catch {
                print("Erro ao deletar: \(error)")
                // completa a ação
                completion(false)
            }
        }
        
        // Define o ícone do botão
        delete.image = UIImage(systemName: "trash")
        // Define a background do botão
        
        delete.backgroundColor = UIColor.systemRed
        
        // define a configuração do swipe, o primeiro é o que fica sempre mais à borda do elemento
        let config = UISwipeActionsConfiguration(actions: [delete])
        // manter os botões visíveis quando não tiver swipe
        config.performsFirstActionWithFullSwipe = false
        
        // retorna a configuração
        return config
    }
}

