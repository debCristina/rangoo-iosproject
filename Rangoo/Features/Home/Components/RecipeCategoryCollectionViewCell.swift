//
//  CollectionViewCell.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 14/01/26.
//
import Foundation
import UIKit

class RecipeCategoryCollectionViewCell: UICollectionViewCell, ViewProtocol {
   static let identifier: String = "RecipeCategoryCollectionViewCell"
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [recipeImage, recipeName])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .fill
        return stackView
    }()
    
    private lazy var recipeImage: RemoteImageView = {
        let image = RemoteImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .systemGray6
        image.clipsToBounds = true
        image.layer.cornerRadius = 15
        return image
        
    }()
    
    private lazy var recipeName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.customFont(type: .regular, size: 11)
        label.textAlignment = .center
        label.textColor = .black

        return label
    }()
    
    func configure(with recipe: Recipe) {
        recipeName.text = recipe.title
        
        if let url = URL(string: recipe.image) {
            recipeImage.load(url: url)
        }
    }
    
    func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    func setHierarchy() {
        contentView.addSubview(stackView)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            recipeImage.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
