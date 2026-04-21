//
//  IngredientsTableViewCell.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 16/04/26.
//

import UIKit

class IngredientsTableViewCell: UITableViewCell, ViewProtocol {
    
    static let identifier: String = "IngredientsTableViewCell"
    
    private lazy var ingedientTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Alho"
        label.textColor = UIColor.black
        label.font = UIFont.customFont(type: .regular, size: 14)
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var ingredientQuantity: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "max 25°C"
        label.font = UIFont.customFont(type: .regular, size: 14)
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        lazy var stackView = UIStackView(arrangedSubviews: [ingedientTitle, ingredientQuantity])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16,
                                                                     leading: 16,
                                                                     bottom: 16,
                                                                     trailing: 16)
        stackView.spacing = 15
        
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
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
