//
//  RecipeDetailViewController.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 13/04/26.
//

import Foundation
import  UIKit

// MARK: - View controller responsavel pela comunicacao entre view model -> view
class RecipeDetailViewController: UIViewController {
    
    // MARK: - Configura variáveis
    // View responsavel pela exibicao
    let recipeDetailView = RecipeDetailView()
    private var selectedSegment = 0
    
    // MARK: - Inicializacao da classe com a sua respectiva view model
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuracoes para quando a view carregar
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Adiciona a view
        view = recipeDetailView
        
        recipeDetailView.tableView.dataSource = self
        recipeDetailView.tableView.contentInsetAdjustmentBehavior = .never
        recipeDetailView.onSegmentChanged = { [weak self] index in
            guard let self else { return }
            
            self.selectedSegment = index
            self.recipeDetailView.tableView.reloadData()
        }
    }
}

extension RecipeDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if selectedSegment == 0 {
            return 10 // ingredientes
        } else {
            return 5 // instruções
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if selectedSegment == 0 {
            
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: IngredientsTableViewCell.identifier,
                for: indexPath
            ) as? IngredientsTableViewCell else {
                return UITableViewCell()
            }
            
            return cell
            
        } else {
            
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: InstructionsTableViewCell.identifier,
                for: indexPath
            ) as? InstructionsTableViewCell else {
                return UITableViewCell()
            }
            
            return cell
        }
    }
    
    
}
