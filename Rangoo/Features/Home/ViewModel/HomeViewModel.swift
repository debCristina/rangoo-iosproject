//
//  HomeViewModel.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 14/01/26.
//

import Foundation

class HomeViewModel {
    // Utilizando o serviço de receita
    private let service: RecipeService
    
    // Lista de receitas
    var recipes: [Recipe] = []
    
    // Sessoes de receitas
    var sections: [RecipeSection] = []
    
    // Inicializando a view mode, com a classe de serviço
    init(recipeService: RecipeService = RecipeService()) {
        self.service = recipeService
        
    }
    
    // Buscando receitas utilizando o método da service
    func fetchRecipes(completion: @escaping () -> Void) {
        service.fetchRandomRecipes{ [weak self] result in
            switch result {
            case.success(let response):
                self?.recipes = response.recipes
                self?.createSections()
                completion()
                print(response.recipes)


            case.failure(let error):
                print("Error fetching recipes: \(error)")
            }
        }
    }
    
    // organizar as receitas por categoria
    func createSections() {
        
        // Retorna todas as categorias
        sections = SectionKind.allCases.compactMap { kind in
            // pega todas as categorias
            let recipesForSection = filterRecipes(for: kind)
            // Se alguma categoria for vazia , retona nil
            if recipesForSection.isEmpty {
                return nil
            }
            
            // Se não for vazia retona a sessao
            return RecipeSection(section: kind, recipes: recipesForSection)
        }
    }
    
    // Filtrar receita pelo tipo de sessão esperado
    func filterRecipes(for section: SectionKind) -> [Recipe] {
        switch section {
            // Caso almoco procura todas as receitas onde dishTypes contenha lunch
        case .lunch:
            return recipes.filter {
                $0.dishTypes?.contains("lunch") == true
            }
            // Caso dinner procura todas as receitas onde dishTypes contenha dinner
        case .dinner:
            return recipes.filter {
                $0.dishTypes?.contains("dinner") == true
            }
            // Caso main dish procura todas as receitas onde dishTypes contenha main dish
        case .breakFast:
            return recipes.filter {
                $0.dishTypes?.contains("breakfast") == true
            }
            
        case .salads:
            return recipes.filter {
                $0.dishTypes?.contains("salad") == true
            }
        case .sideDishes:
            return recipes.filter {
                $0.dishTypes?.contains("side dish") == true
            }
        case .soups:
            return recipes.filter {
                $0.dishTypes?.contains("soup") == true
            }
            
        case .mainDish:
            return recipes.filter {
                $0.dishTypes?.contains("main dish") == true
            }
        case .snack:
            return recipes.filter {
                $0.dishTypes?.contains("snack") == true
            }
        case .dessert:
            return recipes.filter {
                $0.dishTypes?.contains("dessert") == true
            }
        case .appetizer:
            return recipes.filter {
                $0.dishTypes?.contains("appetizer") == true
            }
        }
        
    }

}
