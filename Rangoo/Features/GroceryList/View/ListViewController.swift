//
//  HomeViewController.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 13/01/26.
//

import UIKit

class ListViewController: UIViewController {
    private let groceryListView = ListView()
    
    // View model responsavel por transmitir os dados
    private let viewModel: GroceryListViewModel
    
    
    // MARK: - Inicializacao da classe com a sua respectiva view model
    init(viewModel: GroceryListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.systemBlue
        setupNavigation()
        view.backgroundColor = .white
        view = groceryListView
        groceryListView.groceryListTableView.dataSource = self
        groceryListView.groceryListTableView.delegate = self

    }
    
    
    private func setupNavigation() {
        // Define o título da navegação
        title = "Grocery list"
        
        // Ativa o titulo maior
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Configura a fonte do título
        let font = UIFont.customFont(type: .semiBold, size: 30)
        
        // Adiciona os atributos como cor e fonte do titulo
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.black, .font: font]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(   barButtonSystemItem: .add,
                                                               
                                                               target: self,
                                                               
                                                               action: #selector(didTapAdd)
                                                               
        )
        

    }
    
    @objc private func didTapAdd() {
        
        print("Adicionar item")
        
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: GroceryListTableViewCell.identifier,
            for: indexPath
        ) as? GroceryListTableViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    
}

extension ListViewController: UITableViewDelegate {
    // MARK: - Função responsável por implementar swipe actions da direita pra esquerda
        
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // Definindo a primeira ação como uma ação destrutiva de deleção
        let delete = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, completion in
            
            // chama a função da view model
            self?.viewModel.deleteList()
            
            // completa a ação
            completion(true)
        }
        
        // Define o ícone do botão
        delete.image = UIImage(systemName: "trash")
        // Define a background do botão
        delete.backgroundColor = UIColor.systemRed
        
        // Define a segunda ação como uma ação normal de edição
        let edit = UIContextualAction(style: .normal, title: "Edit") { [weak self] _, _, completion in
            
            // chama o método da view model de edição
            self?.viewModel.editList()
            
            // completa a ação
            completion(true)
            
        }
        
        // Define o ícone
        edit.image = UIImage(systemName: "pencil")
        
        // Define o background
        edit.backgroundColor = UIColor.systemYellow
        
        // define a configuração do swipe, o primeiro é o que fica sempre mais à borda do elemento
        let config = UISwipeActionsConfiguration(actions: [delete, edit])
        // manter os botões visíveis quando não tiver swipe
        config.performsFirstActionWithFullSwipe = false

        // retorna a configuração
        return config
    }
}
