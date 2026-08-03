//
//  HomeViewModel.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 14/01/26.
//

import Foundation
import Combine

// MARK: - View model respnsável por transmitir os dados para a RecipesViewController
class RecipesViewModel {
    
    // MARK: - Configuração das variáveis
    
    // Referencia ao protocolo do coordinator
    weak var coordinator: RecipeCoordinatorProtocol?
    
    // Utilizando o serviço de receita
    private let service: RecipeService
    
    private var recipesByCategory: [SectionKind: [Recipe]] = [:]

    // Lista de receitas
    var recipes: [Recipe] = []
    
    // Sessoes de receitas
    @Published var sections: [RecipeSection] = []

    // MARK: - Inicializando a view mode, com a classe de serviço
    init(recipeService: RecipeService) {
        self.service = recipeService
    }
    
    // MARK: - Comunica o coordinator para ir para a tela de lista por categoria
    func goToList(category: SectionKind) {
        let recipes = recipesByCategory[category] ?? []
        coordinator?.navigateToRecipeList(category: category, recipes: recipes)
    }
    
    // MARK: - Comunica o coordinator para ir para o detalhe da receita selecionada
    func goToRecipeDetail(recipe: Recipe) {
        coordinator?.navigateToRecipeDetail(recipe: recipe)
    }
    
    // MARK: - Buscando receitas utilizando o método da service
    func fetchRecipes() {
        
        // Cria um grupo para executar tarefas
        let group = DispatchGroup()
        
        for kind in SectionKind.allCases {
            // Avisa quando uma terefa começou
            group.enter()
            
            // Execução da tarefa de forma assíncrona
            service.fetchRecipesByType(type: kind) { [weak self] result in
                // finaliza a tarefa ao final independente de caso de sucesso ou falha
                defer { group.leave() }
                
                switch result {
                case .success(let recipes):
                    self?.recipesByCategory[kind] = recipes
                case .failure(let error):
                    print("Erro ao buscar \(kind.sectionTitle): \(error)")
                }
            }
        }
        
        // Quando todas as requisições terminarem
        group.notify(queue: .main) { [weak self] in
            self?.createSections()
        }
    }
    
    // MARK: - organizar as receitas por categoria
    private func createSections() {
        sections = SectionKind.allCases.compactMap { kind in
            guard let recipes = recipesByCategory[kind],
                  !recipes.isEmpty else { return nil }
            
            return RecipeSection(section: kind, recipes: recipes)
        }
    }
}


