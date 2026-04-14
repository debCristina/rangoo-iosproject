//
//  IngredientsView.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 14/04/26.
//

import Foundation
import UIKit

final class IngredientsView: UIView, ViewProtocol {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setHierarchy()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = .black
    }
    
    func setHierarchy() {
        
    }
    
    func setConstraints() {
        
    }
    
    
}
