//
//  GroceryHeaderView.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 06/05/26.
//

import Foundation
import UIKit

// MARK: - Header da table view de detalhes
class GroceryDetailHeaderView: UIView, ViewProtocol {
    
    // MARK: - Variaveis de configuração
    
    // Identificador do header
    static let identifier: String = "GreceryHeaderView"

    
    // titulo do total
    private lazy var totalAmountTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        label.font = UIFont.customFont(type: .semiBold, size: 20)
        label.text = "Total da lista:"

        return label
    }()
    
    // total de itens
    private lazy var totalItems: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        label.font = UIFont.customFont(type: .regular, size: 18)
        label.text = "5 itens"
        return label
    }()
    
    // valor total da lista
    private lazy var totalAmountValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        label.font = UIFont.customFont(type: .bold, size: 40)
        label.text = "65"
        
        return label
    }()
    
    // Stack vertical que agrupa o titulo e o numero de itens
    private lazy var stackVertical: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [totalAmountTitle, totalItems])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 0
        return stack
    }()
    
    // Stack horizontal que agrupa a stack vertical e o valor total
    private lazy var stackHorizontal: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [stackVertical, totalAmountValue])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isLayoutMarginsRelativeArrangement = true
        stack.axis = .horizontal
        stack.spacing = 5
        stack.alignment = .fill
        
        
        // Configura a stack para permitir que se extenda além do tamanho natural dela de forma horizontal
        stackVertical.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        // Configura a stack para permitir que ela nao se comprima de forma horizontal
        stackVertical.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        // Configura a stack para permitir que ela não extenda além do tamanho natural dela de forma horizontal
        totalAmountValue.setContentHuggingPriority(.required, for: .horizontal)
        
        // Configura a stack para permitir que ela nao se comprima de forma horizontal
        totalAmountValue.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        stack.backgroundColor = .accent
        stack.clipsToBounds = true
        stack.layer.cornerRadius = 0
        
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 5, leading: 16, bottom: 5, trailing: 16)
        
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
    
    // MARK: - Configura a view
    func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    // MARK: - Adiciona os itens por hierarquia
    func setHierarchy() {
        addSubview(stackHorizontal)
    }
    
    // MARK: - Adiciona constraints
    func setConstraints() {
        NSLayoutConstraint.activate([
            stackHorizontal.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            stackHorizontal.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackHorizontal.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackHorizontal.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 16),
        ])
    }
}
