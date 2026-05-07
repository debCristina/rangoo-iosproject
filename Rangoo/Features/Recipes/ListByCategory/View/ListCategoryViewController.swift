//
//  ListCategoryViewController.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 18/03/26.
//

import Foundation
import  UIKit

// MARK: - View controller responsavel pela comunicacao entre view model -> view
class ListCategoryViewController: UIViewController {
    
    // MARK: - Configura variáveis
    // View responsavel pela exibicao
    let recipeCategoryView = ListCategoryView()
    
    // View model responsavel por transmitir os dados
    private let viewModel: RecipeByCategoryViewModel
    
    
    // MARK: - Inicializacao da classe com a sua respectiva view model
    init(viewModel: RecipeByCategoryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuracoes para quando a view carregar
    override func viewDidLoad() {
        super.viewDidLoad()
        // Adiciona a view
        view = recipeCategoryView
        // Define a propria view controller como data source
        recipeCategoryView.recipeCategoryTableView.dataSource = self
        recipeCategoryView.recipeCategoryTableView.delegate = self
        // Recebe o nome para ser exibido na pagina
        title = viewModel.category.sectionTitle
    }
    
}

// MARK: - Data source responsavel por configurar as informacoes da table view
extension ListCategoryViewController: UITableViewDataSource {
    // MARK: - Funcao responsavel pelo numero de linhas na sessao
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.recipes.count
    }
    
    // MARK: - Funcao responsavel por cionfigurar a celula na table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ListCategoryViewCell.identifier,
            for: indexPath
        ) as? ListCategoryViewCell else {
            return UITableViewCell()
        }
        // Recebe a receita a ser exibida
        let recipe = viewModel.recipes[indexPath.row]
        // Configura as celulas com as informacoes das receitas
        cell.configure(with: recipe)
        
        return cell
    }
}

extension ListCategoryViewController: UITableViewDelegate {
    // MARK: - Detecta clique na celula
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = viewModel.recipes[indexPath.row]
        
        // Chama o coordinator para navegar
        viewModel.goToRecipeDetail(recipe: recipe)
    }
}

