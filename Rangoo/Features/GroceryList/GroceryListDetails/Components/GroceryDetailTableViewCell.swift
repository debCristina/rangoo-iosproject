//
//  GroceryDetailTableViewCell.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 06/05/26.
//

import UIKit

// MARK: - Celula da table view dos itens da lista
class GroceryDetailTableViewCell: UITableViewCell, ViewProtocol {
   
    // MARK: - Variaveis de configuracoes
    
    // Identificador da célula
    static let identifier: String = "GreceryDetailTableViewCell"
    
    // Titulo do item da lista
    private lazy var itemTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.customFont(type: .bold, size: 20)
        label.text = "Leite"
        label.numberOfLines = 1
        label.textColor = UIColor.fontColor

        return label
    }()
    
    // Quantidade do item da lista
    private lazy var itemQuantity: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.customFont(type: .regular, size: 16)
        label.text = "Quantidade"
        label.numberOfLines = 1
        label.textColor = UIColor.fontColor
        return label
    }()
    
    // Valor do item da lista
    private lazy var itemValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.customFont(type: .regular, size: 16)
        label.text = "Valor unitário"
        label.numberOfLines = 1
        label.textColor = UIColor.fontColor
        return label
    }()
    
    // Stck que agrupa o titulo, quantidade e o valor
    private lazy var stackVertical: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [itemTitle, itemQuantity, itemValue])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .fill
      
        return stack
    }()
    
    
    // MARK: - Método de inicialização
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        separatorInset = .zero
        
        layoutMargins = .zero
        
        preservesSuperviewLayoutMargins = false
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - Seleciona o item
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    // MARK: - Configura a view
    func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    // MARK: - Adiciona os itens por hierarquia
    func setHierarchy() {
        contentView.addSubview(stackVertical)
    }
    
    // MARK: - Adiciona contraints
    func setConstraints() {
        NSLayoutConstraint.activate([
            stackVertical.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            stackVertical.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant:  16),
            stackVertical.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 16),
            stackVertical.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
}
