//
//  ListCategoryView.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 24/03/26.
//

import UIKit

// MARK: - View da lista de receitas por categoria
class ListCategoryView: UIView, ViewProtocol {
    // MARK: - Configuracao de variavel
    
    // Cria a table view
     lazy var recipeCategoryTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
         tableView.backgroundColor = .clear
        tableView.separatorColor = .white
         // Registra a celula
        tableView.register(ListCategoryViewCell.self, forCellReuseIdentifier: ListCategoryViewCell.identifier)
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
        addSubview(recipeCategoryTableView)
        
    }
    
    // MARK: - Configura constraints
    func setConstraints() {
        NSLayoutConstraint.activate([
            recipeCategoryTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor), 
            recipeCategoryTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            recipeCategoryTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            recipeCategoryTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

}
