//
//  GroceryListTableViewCell.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 05/05/26.
//

import UIKit

class GroceryListTableViewCell: UITableViewCell, ViewProtocol {
    // MARK: - Variaveis de configuração
    // Identificador da celula
    static let identifier: String = "GroceryListTableViewCell"
    
    // Nome da receita
    private lazy var listName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.fontColor
        label.font = UIFont.customFont(type: .medium, size: 18)
        label.numberOfLines = 1
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
        return label
    }()
    
    // Imagem da lista
    private lazy var listImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // Stack vertical que agrupa o nome da lista e o numero de itens
    private lazy var stackVertical: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [listName, listNumberItens])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        
        return stack
    }()
    
    // Stack horizontal que agrupa a imagem e a stack vertical
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
    
    // MARK: - Método de inicialização
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - Configura a célula com os dados da lista
    func configure(with list: GroceryList) {
        listName.text = list.name
        
        let itemCount = (list.items as? Set<ListItem>)?.count ?? 0
        listNumberItens.text = "\(itemCount) itens"
        
        if let imageData = list.image, let image = UIImage(data: imageData) {
            listImage.image = image
        } else {
            listImage.image = UIImage(named: "recipeImage")
        }
    }
    
    // MARK: - Seleciona o item
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    // MARK: - Seta a view
    func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    // MARK: - Organiza a hierarquia da view
    func setHierarchy() {
        contentView.addSubview(stackHorizontal)
    }
    
    // MARK: - Adiciona constraints
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
