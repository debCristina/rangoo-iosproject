//
//  GroceryListDetailView.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 06/05/26.
//

import Foundation
import UIKit

// MARK: - View de detalhes da lista
class GroceryListDetailView: UIView, ViewProtocol {
    
    // MARK: - Variaveis de configuração
    // Header da lista
    let header = GroceryDetailHeaderView()
    
    // Lista de listas
    let groceryItemstableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(
            GroceryDetailTableViewCell.self,
            forCellReuseIdentifier: "GreceryDetailTableViewCell"
        )
        
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 120
        return table
        
    }()
    
    // MARK: - Incializacao da view
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Função de configuração do header
    func setupHeader() {
        header.frame = CGRect(x: 0, y: 0, width: frame.width, height: 70)
        
        groceryItemstableView.tableHeaderView = header
    }
    
    // MARK: - Configura a view
    func setupView() {
        setHierarchy()
        setConstraints()
        setupHeader()
    }
    
    // MARK: - Adiciona os itens por hierarquia
    func setHierarchy() {
        addSubview(groceryItemstableView)
    }
    
    // MARK: - Adiciona constraints
    func setConstraints() {
        NSLayoutConstraint.activate([
            groceryItemstableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            groceryItemstableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            groceryItemstableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            groceryItemstableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
