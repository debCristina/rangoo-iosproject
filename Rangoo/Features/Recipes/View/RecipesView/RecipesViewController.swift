//
//  HomeViewController.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 13/01/26.
//

import UIKit
import Combine

// MARK: - View controller responsável pela comunicação entre view -> viewModel
class RecipesViewController: UIViewController {
    // MARK: - Configuração das variaveis
    
    // View da lista de receitas
    private let recipeView = RecipesView()
    
    // View Model responsável por transmitir os dados
     private let viewModel:  RecipesViewModel

    // Barra de pesquisa
    private let searchView = SearchController()
    
    // Salva a subscription no Set
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Função de inicialização
    init(viewModel: RecipesViewModel) {
        // Rcebe a view model
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Função de carregar a view
    override func loadView() {
        view = recipeView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Configuração para quando a view carregar
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configura navegação
        setupNavigation()
        
        // Define o data source da collection view como a própria view controller
        recipeView.recipeCategoryView.recipesCollectionView.dataSource = self
        
        recipeView.recipeCategoryView.recipesCollectionView.delegate = self
//        homeView.recipeCategoryView.recipesCollectionView.delegate = self
        
        // Bind com a view model
        bindViewModel()
        
        // Carrega receitas
        viewModel.fetchRecipes()
    }
    
    // MARK: - Configura navegação
    private func setupNavigation() {
        // Define o título da navegação
        title = "Recipes"
        
        // Ativa o titulo maior
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Configura a fonte do título
        let font = UIFont.customFont(type: .semiBold, size: 30)
        
        // Adiciona os atributos como cor e fonte do titulo
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.black, .font: font]
        
        // Cria a search view
        navigationItem.searchController  = SearchController.make()
    }
    
    // MARK: - Utilizando método de subscrição do combine
    private func bindViewModel() {
        // Acessando o publisher
        viewModel.$sections
            // Garante que rode na main thread
            .receive(on: DispatchQueue.main)
            //Verifica se algo mudou
            .sink { [weak self] _ in
                // se algo mudou chama o reload data
                self?.recipeView.recipeCategoryView.recipesCollectionView.reloadData()
            }
            // Salva a subscription no Set. Se não fizer isso, a subscription morre na hora e o sink nunca é chamado.
            .store(in: &cancellables)
    }
}

// MARK: - Extensão da view controller que será utilizado como data source
extension RecipesViewController: UICollectionViewDataSource {
    // MARK: - Método que informa quantos elementos vamos ter em cada seção
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.sections[section].recipes.count
    }
    
    // MARK: - Método que informa quantos sessões vamos ter
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.sections.count
    }
    
    // MARK: - Função de informa qual celula irá aparecer em cada posição
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
    
    // MARK: - Configura o título
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier, for: indexPath) as! HeaderCollectionReusableView
        
        let sectionKind = viewModel.sections[indexPath.section].section
        header.configure(title: sectionKind.sectionTitle)
        
        header.onButtonTapped = { [weak self] in
            guard let self = self else { return }
            
            let category = self.viewModel.sections[indexPath.section].section
            self.viewModel.goToList(category: category)
        }
        
        return header
    }
}

extension RecipesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let recipe = viewModel.sections[indexPath.section].recipes[indexPath.item]
        
        viewModel.goToRecipeDetail(recipe: recipe)
    }
}
