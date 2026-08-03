//
//  AddListPopover.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 10/07/26.
//

import Foundation
import UIKit

class AddListModalView: UIView, ViewProtocol {
    var listName: String {
        get {
            listNameTextField.text ?? ""
        }
        set {
            listNameTextField.text = newValue
        }
    }
    
    private lazy var listNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.customFont(type: .regular, size: 20)
        label.text = "Nome"
        label.numberOfLines = 1
        label.textColor = UIColor.fontColor
        return label
    }()
    
    private lazy var listNameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Value"
        textField.font = UIFont.customFont(type: .regular, size: 20)
        textField.textColor = UIColor.systemGray
        textField.borderStyle = .none
        return textField
    }()
    
    private lazy var hStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [listNameLabel, listNameTextField])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 30
        stack.alignment = .fill
        stack.distribution = .fill
    
        return stack
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    func setHierarchy() {
        addSubview(hStack)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            hStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            hStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
}

import SwiftUI

#if DEBUG

struct AddListPreview: PreviewProvider {
    
    static var previews: some View {
        
        UIViewPreview {
            
            AddListModalView()
            
        }
        
        .previewLayout(.sizeThatFits)
        
        .padding()
        
    }
    
}

#endif
