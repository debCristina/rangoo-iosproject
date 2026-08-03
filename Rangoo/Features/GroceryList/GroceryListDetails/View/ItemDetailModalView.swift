//
//  ItemDetailModalView.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 13/05/26.
//

import Foundation
import UIKit

struct ItemFormData {
    let name: String
    let price: Double
    let quantity: Int
    let unit: String
}

class ItemDetailModalView: UIView, ViewProtocol {
    
    // Titulo do item da lista
    private lazy var nameTextFieldTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.customFont(type: .regular, size: 20)
        label.text = "Nome"
        label.numberOfLines = 1
        label.textColor = UIColor.fontColor
        
        return label
    }()
    
    // Titulo do item da lista
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Value"
        textField.font = UIFont.customFont(type: .regular, size: 20)
        textField.textColor = UIColor.systemGray
        textField.borderStyle = .none
        
        return textField
    }()
    
    // Titulo do item da lista
    private lazy var quantityTextFieldTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.customFont(type: .regular, size: 20)
        label.text = "Quantity"
        label.numberOfLines = 1
        label.textColor = UIColor.fontColor
        
        return label
    }()
    
    // Titulo do item da lista
    private lazy var quantityTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Value"
        textField.font = UIFont.customFont(type: .regular, size: 20)
        textField.textColor = UIColor.systemGray
        textField.borderStyle = .none
        
        return textField
    }()
    
    // Titulo do item da lista
    private lazy var priceTextFieldTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.customFont(type: .regular, size: 20)
        label.text = "Price"
        label.numberOfLines = 1
        label.textColor = UIColor.fontColor
        
        return label
    }()
    
    // Titulo do item da lista
    private lazy var priceTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Value"
        textField.font = UIFont.customFont(type: .regular, size: 20)
        textField.textColor = UIColor.systemGray
        textField.borderStyle = .none
        
        return textField
        
    }()
    
    // Titulo do item da lista
    private lazy var unitTextFieldTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.customFont(type: .regular, size: 20)
        label.text = "Unit"
        label.numberOfLines = 1
        label.textColor = UIColor.fontColor
        
        return label
    }()
    
    // Titulo do item da lista
    private lazy var unitTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Value"
        textField.font = UIFont.customFont(type: .regular, size: 20)
        textField.textColor = UIColor.systemGray
        textField.borderStyle = .none
        
        return textField
    }()
    
    private lazy var nameStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameTextFieldTitle, nameTextField])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 30
        stack.alignment = .fill
        stack.distribution = .fill
        nameTextFieldTitle.setContentHuggingPriority(.required, for: .horizontal)
        nameTextField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        return stack
    }()
    
    private lazy var quantityStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [quantityTextFieldTitle, quantityTextField])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 30
        stack.alignment = .fill
        stack.distribution = .fill
        
        return stack
    }()
    
    //    private lazy var quantityStack: UIStackView = {
    //        let stack = UIStackView(arrangedSubviews: [quantityTextFieldTitle, c])
    //        stack.translatesAutoresizingMaskIntoConstraints = false
    //        stack.axis = .horizontal
    //        stack.spacing = 30
    //        stack.alignment = .fill
    //        stack.distribution = .fill
    //        
    //        return stack
    //    }()
    
    private lazy var priceStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [priceTextFieldTitle, priceTextField])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 30
        stack.alignment = .fill
        stack.distribution = .fill
        
        return stack
    }()
    
    private lazy var unitStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [unitTextFieldTitle, unitTextField])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 30
        stack.alignment = .fill
        stack.distribution = .fill
        unitTextFieldTitle.setContentHuggingPriority(.required, for: .horizontal)
        unitTextField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        return stack
    }()
    
    // Stck que agrupa o titulo, quantidade e o valor
    private lazy var stackVertical: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameStack, quantityStack,unitStack, priceStack])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .fill
        
        return stack
    }()
    
    // MARK: - Incializacao da view
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with item: ListItem) {
        nameTextField.text = item.name
        quantityTextField.text = "\(item.quantity)"
        priceTextField.text = "\(item.price)"
        unitTextField.text = item.unit
    }
    
    
    func getItemData() -> ItemFormData {
        ItemFormData(
            name: nameTextField.text ?? "",
            price: Double(priceTextField.text ?? "") ?? 0,
            quantity: Int(quantityTextField.text ?? "") ?? 0,
            unit: unitTextField.text ?? ""
        )
    }
    
    func setupView() {
        backgroundColor = .white
        setHierarchy()
        setConstraints()
        backgroundColor = .systemBackground
        layer.cornerRadius = 20
    }
    
    func setHierarchy() {
        addSubview(stackVertical)
    }
    
    // MARK: - Adiciona constraints
    func setConstraints() {
        NSLayoutConstraint.activate([
            stackVertical.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            stackVertical.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackVertical.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
}

import SwiftUI

#if DEBUG

struct ItemDetailModalView_Preview: PreviewProvider {
    
    static var previews: some View {
        
        UIViewPreview {
            
            ItemDetailModalView()
            
        }
        
        .previewLayout(.sizeThatFits)
        
        .padding()
        
    }
    
}

struct UIViewPreview<View: UIView>: UIViewRepresentable {
    
    
    
    let builder: () -> View
    
    
    
    init(_ builder: @escaping () -> View) {
        
        self.builder = builder
        
    }
    
    
    
    func makeUIView(context: Context) -> View {
        
        builder()
        
    }
    
    
    
    func updateUIView(_ uiView: View, context: Context) {}
    
}

#endif
