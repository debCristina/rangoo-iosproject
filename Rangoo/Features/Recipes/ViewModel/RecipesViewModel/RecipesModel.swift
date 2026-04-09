//
//  RecipesModel.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 16/01/26.
//

import Foundation

// MARK: - Categorias exibidas para listar receitas
enum SectionKind: Int, CaseIterable {
    case lunch
    case dinner
    case mainDish
    case breakFast
    case salads
    case soups
    case sideDishes
    case snack
    case dessert
    case appetizer
    
    var sectionTitle: String {
        switch self {
        case .lunch: return "Lunch"
        case .dinner: return "Dinner"
        case .mainDish: return "Main dish"
        case .breakFast: return "Breakfast"
        case .salads: return "Salads"
        case .soups: return "Soups"
        case .sideDishes: return "Side dish"
        case .snack: return "Snack"
        case .dessert: return "Dessert"
        case .appetizer: return "Appetizer"
        }
    }
    
    // Valor que a API Spoonacular espera na query
    var rawQueryValue: String {
        switch self {
        case .lunch:      return "lunch"
        case .dinner:     return "dinner"
        case .mainDish:   return "main course"
        case .breakFast:  return "breakfast"
        case .salads:     return "salad"
        case .soups:      return "soup"
        case .sideDishes: return "side dish"
        case .snack:      return "snack"
        case .dessert:    return "dessert"
        case .appetizer:  return "appetizer"
        }
    }
}

// MARK: - Sessão e receitas por sessão
struct RecipeSection {
    let section: SectionKind
    let recipes: [Recipe]
}
