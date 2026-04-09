//
//  Fonts.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 14/01/26.
//

import Foundation
import UIKit

// MARK: - Fonte personalizada 
extension UIFont {
    enum FontType {
        case regular
        case medium
        case semiBold
        case bold
        case extraBold
        
        func getFontName() -> String {
            switch self {
            case .regular:
                return "Baloo2-Regular"
            case .medium:
                return "Baloo2-Medium"
            case.semiBold:
                return "Baloo2-SemiBold"
            case .bold:
                return "Baloo2-Bold"
            case .extraBold:
                return "Extra-Bold"
            }
        }
        
        func getWeight() -> UIFont.Weight {
            switch self {
            case .regular:
                return .regular
            case .medium:
                return .medium
            case.semiBold:
                return .semibold
            case .bold:
                return .bold
            case .extraBold:
                return .bold
            }
        }
    }
    
    static func customFont(type: FontType, size: CGFloat) -> UIFont {
        guard let font = UIFont(name: type.getFontName(), size: size) else {
            return UIFont.systemFont(ofSize: size, weight: type.getWeight())
        }
        return font
    }
}
