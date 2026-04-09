//
//  CollectionViewCell.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 14/01/26.
//
import Foundation
import UIKit

// MARK: - Celula utilizada pela collection view
class RecipeCategoryCollectionViewCell: UICollectionViewCell, ViewProtocol {
    
    // MARK: - Configuracao das variaveis
    
    // Identificador da celula
   static let identifier: String = "RecipeCategoryCollectionViewCell"
    
    // Stack view vertical para agrupar a imagem e o nome da receita
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [recipeImage, recipeName])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .fill
        return stackView
    }()
    
    // Imagem da receita
    private lazy var recipeImage: RemoteImageView = {
        let image = RemoteImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .systemGray6
        image.clipsToBounds = true
        image.layer.cornerRadius = 15
        return image
        
    }()
    
    // Nome da receita
    private lazy var recipeName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.customFont(type: .regular, size: 11)
        label.textAlignment = .center
        label.textColor = UIColor.fontColor
        return label
    }()
    
    // MARK: - Inicializaca da celula
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Funcao para configurar o nome e a imagem com dados dinamicos
    func configure(with recipe: Recipe) {
        
        // Configura o titulo
        recipeName.text = recipe.title
        
        // Carrega a imagem que vem em URL
        if let url = URL(string: recipe.image) {
            recipeImage.load(url: url)
        }
    }
    
    // MARK: - Configura a vuew
    func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    // MARK: - Configura a view por ordem de hierarquia
    func setHierarchy() {
        contentView.addSubview(stackView)
    }
    
    // MARK: - Configura as constraints
    func setConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            recipeImage.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    
}
