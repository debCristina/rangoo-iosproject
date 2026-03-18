//
//  RecipesModel.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 16/01/26.
//

import Foundation

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
}

struct RecipeSection {
    let section: SectionKind
    let recipes: [Recipe]
}
