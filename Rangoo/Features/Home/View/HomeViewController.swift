//
//  HomeViewController.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 13/01/26.
//

import UIKit

class HomeViewController: UIViewController {
    let service = RecipeService()
    private let homeView = HomeView()
    private let viewModel = HomeViewModel()
    
    private let searchView = SearchController()
    
   
    override func loadView() {
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        homeView.recipeCategoryView.recipesCollectionView.dataSource = self
        homeView.recipeCategoryView.recipesCollectionView.delegate = self
        fetchRecipes()
   }
    
    private func setupNavigation() {
        title = "Recipes"
        navigationController?.navigationBar.prefersLargeTitles = true
        let font = UIFont.customFont(type: .semiBold, size: 30)
        
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.black, .font: font]
        navigationItem.searchController  = SearchController.make()
    }
    
    private func fetchRecipes() {
        viewModel.fetchRecipes { [weak self] in
            DispatchQueue.main.async {
                self?.homeView.recipeCategoryView.recipesCollectionView.reloadData()
            }
        }
    }
    
}

// Extensão da view controller que será utilizado como data source
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // Método que informa quantos elementos vamos ter em cada seção
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.sections[section].recipes.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.sections.count
    }
    
    // Função de informa qual celula irá aparecer em cada posição
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Solicita à collection view uma célula reutilizável registrada anteriormente usando o identificador da HourlyForecastCollectionViewCell.
        // Se existir uma célula fora da tela disponível na fila de reutilização, ela será reaproveitada; caso contrário, uma nova célula será criada.
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeCategoryCollectionViewCell.identifier, for: indexPath) as? RecipeCategoryCollectionViewCell else {
            
            return UICollectionViewCell()
        }
        
        let recipe = viewModel.sections[indexPath.section].recipes[indexPath.item]
        
        cell.configure(with: recipe)
        
        
        // Neste ponto, a célula já existe (nova ou reutilizada), mas ainda NÃO está configurada com dados específicos.
        // Normalmente aqui chamaria um método como configure(...) para preencher labels, imagens e estados visuais da célula.
        // Retorna a célula para que a collection view possa posicioná-la e exibi-la na tela no indexPath informado.
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier, for: indexPath) as! HeaderCollectionReusableView
        
        let sectionKind = SectionKind(rawValue: indexPath.section)
        header.configure(title: sectionKind?.sectionTitle ?? "")
        return header
    }
}

