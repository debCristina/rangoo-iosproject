//
//  HomeView.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 13/01/26.

import Foundation
import UIKit

// Classe de componentes da Home
class HomeView: UIView, ViewProtocol {
    // Coleção de receitas
    let recipeCategoryView = RecipesCategoryCollectionView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Função de configurar a view com hieraquia e constraints( ViewProtocol )
    func setupView() {
        self.backgroundColor = UIColor.white
        setHierarchy()
        setConstraints()
    }
    
    // Hierarquia de views
    func setHierarchy() {
        addSubview(recipeCategoryView)
    }
    
    // Constraints definidas
    func setConstraints() {
        recipeCategoryView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recipeCategoryView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            recipeCategoryView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            recipeCategoryView.trailingAnchor.constraint(equalTo: trailingAnchor),
            recipeCategoryView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
