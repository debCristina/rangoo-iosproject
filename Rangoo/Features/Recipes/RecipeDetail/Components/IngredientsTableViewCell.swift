//
//  IngredientsTableViewCell.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 16/04/26.
//

import UIKit

// MARK: - Table view de ingredientes
class IngredientsTableViewCell: UITableViewCell, ViewProtocol {
    // MARK: - Variaveis de configuração
    
    // Identificador da celula
    static let identifier: String = "IngredientsTableViewCell"
    
    // Titulo do ingrediente
    private lazy var ingedientTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.font = UIFont.customFont(type: .regular, size: 14)
        label.numberOfLines = 0
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    // Quantidade do ingrediente
    private lazy var ingredientQuantity: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.customFont(type: .regular, size: 14)
        label.numberOfLines = 1
        return label
    }()
    
    // Stack Horizontal para agrupar titulo e quantidade
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [ingedientTitle, ingredientQuantity])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 15
        
        return stackView
    }()
    
    // MARK: - Função de inicialização
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Seleciona o item da lista
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func configure(name: String, quantity: String) {
        ingedientTitle.text = name
        ingredientQuantity.text = quantity
    }
    
    
    func setupView() {
        selectionStyle = .none
        backgroundColor = .white
        setHierarchy()
        setConstraints()
    }
    
    func setHierarchy() {
        contentView.addSubview(stackView)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            // StackView ocupa toda a célula
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
        
        // Quantity não encolhe, Title expande
        ingredientQuantity.setContentHuggingPriority(.required, for: .horizontal)
        ingredientQuantity.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
}
