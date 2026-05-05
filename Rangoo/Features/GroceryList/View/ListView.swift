//
//  HomeView.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 13/01/26.
//

import Foundation
import UIKit

class ListView: UIView, ViewProtocol {
    
    // Cria a table view
    lazy var groceryListTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorColor = .white
        // Registra a celula
        tableView.register(GroceryListTableViewCell.self, forCellReuseIdentifier: GroceryListTableViewCell.identifier)
        return tableView
    }()
    
    // MARK: - Incializacao da view
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configura a view
    func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    // MARK: - Define a hierarquia das views
    func setHierarchy() {
        addSubview(groceryListTableView)
        
    }
    
    // MARK: - Configura constraints
    func setConstraints() {
        NSLayoutConstraint.activate([
            groceryListTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            groceryListTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            groceryListTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            groceryListTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
