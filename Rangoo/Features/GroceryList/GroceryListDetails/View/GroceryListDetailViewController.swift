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
    
    // MARK: - Função que executa quando a view carregar
    override func viewDidLoad() {
        view.backgroundColor = UIColor.systemBlue
        setupNavigation()
        view.backgroundColor = .white
        view = groceryListDetailView
        groceryListDetailView.groceryItemstableView.dataSource = self
        
    }
    
    // MARK: - Confugura a navegação
    private func setupNavigation() {
        // Define o título da navegação
        title = "Mercado"
        // Ativa o titulo maior
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Configura a fonte do título
        let font = UIFont.customFont(type: .semiBold, size: 30)
        // Adiciona os atributos como cor e fonte do titulo
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.black, .font: font]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(   barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
    }
    
    // MARK: - Açã do botão da toolbar
    @objc private func didTapAdd() {
        print("Adicionar item")
        
    }
}

// MARK: - Data source da table view
extension GroceryListDetailViewController: UITableViewDataSource {
    // MARK: - Define o número de linhas
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    // MARK: - Define a celula a ser exibida
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: GroceryDetailTableViewCell.identifier,
            for: indexPath
        ) as? GroceryDetailTableViewCell else {
            return UITableViewCell()
        }
        
       
        
        return cell
    }
}

