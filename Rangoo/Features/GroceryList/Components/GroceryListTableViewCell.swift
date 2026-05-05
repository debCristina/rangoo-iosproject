//
//  GroceryListTableViewCell.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 05/05/26.
//

import UIKit

class GroceryListTableViewCell: UITableViewCell, ViewProtocol {
    // Identificador da celula
    static let identifier: String = "GroceryListTableViewCell"
    
    // Nome da receita
    private lazy var listName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.fontColor
        label.font = UIFont.customFont(type: .medium, size: 18)
        label.numberOfLines = 1
        label.text = "Mercado"
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    // Nome da receita
    private lazy var listNumberItens: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.fontColor
        label.font = UIFont.customFont(type: .regular, size: 14)
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.text = "50 itens"
        return label
    }()
    
    private lazy var listImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "recipeImage")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var stackVertical: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [listName, listNumberItens])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        
        return stack
    }()
    
    private lazy var stackHorizontal: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [listImage, stackVertical])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 5
        
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
        super.init(coder: coder)
        setupView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    func setHierarchy() {
        contentView.addSubview(stackHorizontal)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            stackHorizontal.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackHorizontal.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackHorizontal.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackHorizontal.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
        listImage.widthAnchor.constraint(equalToConstant: 60).isActive = true
        listImage.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
}
