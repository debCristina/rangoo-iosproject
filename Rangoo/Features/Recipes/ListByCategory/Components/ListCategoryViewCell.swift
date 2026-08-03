//
//  TableViewCell.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 18/03/26.
//

import UIKit
// MARK: - Celula da lista de receitas por categoria
class ListCategoryViewCell: UITableViewCell, ViewProtocol {
    
    // MARK: - Configuração de variáveis
    
    // Identificador da celula
    static let identifier: String = "ListByCategoryViewCell"
    
    // Imagem da receita
    private lazy var recipeImage: RemoteImageView = {
        let imageView = RemoteImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // Nome da receita
    private lazy var recipeName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.fontColor
        label.font = UIFont.customFont(type: .regular, size: 14)
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    // Descricao da receita
    private lazy var recipeDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 4
        label.lineBreakMode = .byTruncatingTail
        label.textColor = UIColor.fontColor
        label.font = UIFont.customFont(type: .regular, size: 12)
        return label
    }()
    
    // Tempo da receita
    private lazy var recipeTime: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.fontColor
        label.font = UIFont.customFont(type: .regular, size: 12)
        return label
    }()
    
    // Stack horizontal que agrupa o nome e o tempo da receita
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
        
        stackView.spacing = 15

        return stackView
    }()
    
    // Stack vertical que agrupa a stack hororizontal com a descricao da receita
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
    
    // Container horizontal que agrupa a imagem com a stack vertical
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
    
    
    // MARK: - Inicialização da celula
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        recipeImage.image = nil
    }
    
    // MARK: - Configura o titulo, descricao e tempo da receita com os dados vindos da api
    func configure(with recipe: Recipe) {
        
        // Configurao nome
        recipeName.text = recipe.title

        // Configura o tempo
        if let time = recipe.readyInMinutes {
            // Padroniza a exibicao do tempo
            recipeTime.text = "\(time) min"
        } else {
            // Se nenhum valor for encontrado o texto será -
            recipeTime.text = "-"
        }
        
        // Configura a descricao com o sumario vindo da api e convertido de HTML para texto
        recipeDescription.text = recipe.summary?.htmlToPlainText
        
        // Carrefa a imagem
        if let url = URL(string: recipe.image) {
            recipeImage.load(url: url)
        }
    }
    
    // MARK: - Configura a view
    func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    // MARK: - Organiza a hierarquia das views
    func setHierarchy() {
        contentView.addSubview(stackViewHorizontalContainer)
    }
    
    // MARK: - Adiciona as constraints para a celula
    func setConstraints() {
        NSLayoutConstraint.activate([
            stackViewHorizontalContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackViewHorizontalContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackViewHorizontalContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackViewHorizontalContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            
        ])
        
        // Define as dimensoes da imagem
        recipeImage.widthAnchor.constraint(equalToConstant: 130).isActive = true
        recipeImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
    }
    
}
