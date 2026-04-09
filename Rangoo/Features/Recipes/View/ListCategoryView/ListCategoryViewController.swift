//
//  ListCategoryViewController.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 18/03/26.
//

import Foundation
import  UIKit

class ListCategoryViewController: UIViewController {
    let recipeCategoryView = ListCategoryView()
    
    private let viewModel: RecipeByCategoryViewModel
    
    init(viewModel: RecipeByCategoryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = recipeCategoryView
        recipeCategoryView.recipeCategoryTableView.dataSource = self
        title = viewModel.category.sectionTitle
    }
}

extension ListCategoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ListCategoryViewCell.identifier,
            for: indexPath
        ) as? ListCategoryViewCell else {
            return UITableViewCell()
        }
        let recipe = viewModel.recipes[indexPath.row]
        cell.configure(with: recipe)
        
        return cell
    }
}
