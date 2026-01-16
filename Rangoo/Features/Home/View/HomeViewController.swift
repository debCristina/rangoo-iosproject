//
//  HomeViewController.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 13/01/26.
//

import UIKit

class HomeViewController: UIViewController {
    private let searchView = SearchController()
    private let recipeCategoryView = RecipesCategoryCollectionView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupNavigation()
        addRecipesCategoryView()
        
    }
    
    private func setupNavigation() {
        title = "Recipes"
        navigationController?.navigationBar.prefersLargeTitles = true
        let font = UIFont.customFont(type: .semiBold, size: 30)

        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.black, .font: font]
        navigationItem.searchController  = SearchController.make()
    }
    
    private func addRecipesCategoryView() {
        recipeCategoryView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(recipeCategoryView)
        
        NSLayoutConstraint.activate([
            recipeCategoryView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            recipeCategoryView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            recipeCategoryView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            recipeCategoryView.bottomAnchor.constraint(equalTo: view.bottomAnchor)

        ])
    }
    
    
}
