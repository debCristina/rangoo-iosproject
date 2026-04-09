//
//  ListCategoryView.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 24/03/26.
//

import UIKit

class ListCategoryView: UIView, ViewProtocol {
     lazy var recipeCategoryTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
         tableView.backgroundColor = .clear
        tableView.separatorColor = .white
        tableView.register(ListCategoryViewCell.self, forCellReuseIdentifier: ListCategoryViewCell.identifier)
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    func setHierarchy() {
        addSubview(recipeCategoryTableView)
        
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            recipeCategoryTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor), 
            recipeCategoryTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            recipeCategoryTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            recipeCategoryTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

}
