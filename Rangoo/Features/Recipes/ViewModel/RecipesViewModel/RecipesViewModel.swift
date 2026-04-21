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
    
    func goToList(category: SectionKind) {
        let recipes = recipesByCategory[category] ?? []
        coordinator?.navigateToRecipeList(category: category, recipes: recipes)
    }
    
    func goToRecipeDetail() {
        coordinator?.navigateToRecipeDetail()
    }
    // MARK: - Buscando receitas utilizando o método da service
    func fetchRecipes() {
        let group = DispatchGroup()
        
        for kind in SectionKind.allCases {
            group.enter()
            
            service.fetchRecipesByType(type: kind) { [weak self] result in
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
    
//    // MARK: - Filtrar receita pelo tipo de sessão esperado
//    func filterRecipes(for section: SectionKind) -> [Recipe] {
//        switch section {
//            // Caso almoco procura todas as receitas onde dishTypes contenha lunch
//        case .lunch:
//            return recipes.filter {
//                $0.dishTypes?.contains("lunch") == true
//            }
//            // Caso dinner procura todas as receitas onde dishTypes contenha dinner
//        case .dinner:
//            return recipes.filter {
//                $0.dishTypes?.contains("dinner") == true
//            }
//            // Caso main dish procura todas as receitas onde dishTypes contenha main dish
//        case .breakFast:
//            return recipes.filter {
//                $0.dishTypes?.contains("breakfast") == true
//            }
//        case .salads:
//            return recipes.filter {
//                $0.dishTypes?.contains("salad") == true
//            }
//        case .sideDishes:
//            return recipes.filter {
//                $0.dishTypes?.contains("side dish") == true
//            }
//        case .soups:
//            return recipes.filter {
//                $0.dishTypes?.contains("soup") == true
//            }
//            
//        case .mainDish:
//            return recipes.filter {
//                $0.dishTypes?.contains("main dish") == true
//            }
//        case .snack:
//            return recipes.filter {
//                $0.dishTypes?.contains("snack") == true
//            }
//        case .dessert:
//            return recipes.filter {
//                $0.dishTypes?.contains("dessert") == true
//            }
//        case .appetizer:
//            return recipes.filter {
//                $0.dishTypes?.contains("appetizer") == true
//            }
//        }
//    }
}


