//
//  TableViewCell.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 18/03/26.
//

import UIKit

class ListCategoryViewCell: UITableViewCell, ViewProtocol {
    static let identifier: String = "ListByCategoryViewCell"
    
    private lazy var recipeImage: RemoteImageView = {
        let imageView = RemoteImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var recipeName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.fontColor
        label.font = UIFont.customFont(type: .regular, size: 14)
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private lazy var recipeDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 4
        label.lineBreakMode = .byTruncatingTail
        label.textColor = UIColor.fontColor
        label.font = UIFont.customFont(type: .regular, size: 12)
        return label
    }()
    
    private lazy var recipeTime: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "45 min"
        label.textColor = UIColor.fontColor
        label.font = UIFont.customFont(type: .regular, size: 12)
        return label
    }()
    
    private lazy var stackViewHorizontal: UIStackView = {
        lazy var stackView = UIStackView(arrangedSubviews: [recipeName, recipeTime])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 0
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.distribution = .fill
        
        // recipeName cede espaço quando necessário
        recipeName.setContentHuggingPriority(.defaultLow, for: .horizontal)
        recipeName.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        // recipeTime nunca encolhe
        recipeTime.setContentHuggingPriority(.required, for: .horizontal)
        recipeTime.setContentCompressionResistancePriority(.required, for: .horizontal)
        
//        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0,
//                                                                     leading: 0,
//                                                                     bottom: 0,
//                                                                     trailing: 0)
        stackView.spacing = 15

        return stackView
    }()
    
    private lazy var stackViewVertical: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [stackViewHorizontal,
                                                       recipeDescription])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 5
        stackView.isLayoutMarginsRelativeArrangement = false

        return stackView
    }()
    
    private lazy var stackViewHorizontalContainer: UIStackView = {
        let  stackView = UIStackView(arrangedSubviews: [
            recipeImage,
            stackViewVertical
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16,
                                                                     leading: 16,
                                                                     bottom: 5,
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
    
    func configure(with recipe: Recipe) {
        recipeName.text = recipe.title

        if let time = recipe.readyInMinutes {
            recipeTime.text = "\(time) min"
        } else {
            recipeTime.text = "-"
        }
        
        recipeDescription.text = recipe.summary?.htmlToPlainText
        
        if let url = URL(string: recipe.image) {
            recipeImage.load(url: url)
        }
    }
    
    func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    func setHierarchy() {
        contentView.addSubview(stackViewHorizontalContainer)
    }
    
    //
    func setConstraints() {
        NSLayoutConstraint.activate([
            stackViewHorizontalContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackViewHorizontalContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackViewHorizontalContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackViewHorizontalContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            
        ])
        
        recipeImage.widthAnchor.constraint(equalToConstant: 130).isActive = true
        recipeImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
    }
    
}
