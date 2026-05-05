//
//  RecipeHeaderView.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 20/04/26.
//

import UIKit

class RecipeHeaderView: UIView, ViewProtocol {
   
    var didTapSegmented: ((Int) -> Void)?
    
    // MARK: - Imagem da receita
    private lazy var recipeImage: RemoteImageView = {
        let imageView = RemoteImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // MARK: - Nome da receita
    private lazy var recipeName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.fontColor
        label.font = UIFont.customFont(type: .bold, size: 20)
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    // MARK: - Tempo da receita
    private lazy var recipeTime: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.fontColor
        label.font = UIFont.customFont(type: .regular, size: 14)
        return label
    }()
    
    private lazy var sectionTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.font = UIFont.customFont(type: .bold, size: 18)
        label.numberOfLines = 1

        return label
        
    }()
    
    func updateTitle(for index: Int) {
        sectionTitle.text = index == 0 ? "Ingredientes" : "Instruções"
    }
    
    // MARK: - variavel de controle de estado
    private lazy var segmentedControl: UISegmentedControl = {
        // cria os botões com base nos segmentos
        let control = UISegmentedControl(items: ["Ingredientes", "Instruções"])
        
        // começa com o primeiro indice selecionado, no caso "ingredients"
        control.selectedSegmentIndex = 0
        
        // ativa o auto layout
        control.translatesAutoresizingMaskIntoConstraints = false
        
        // define aparência quando selecionado
        control.setTitleTextAttributes([.font: UIFont.customFont(type: .semiBold, size: 14)], for: .selected)
        
        // define aparência quando não selecionado
        control.setTitleTextAttributes([.font: UIFont.customFont(type: .regular, size: 14)], for: .normal)
        
        // cor do highlight do segmento selecionado
        control.selectedSegmentTintColor = UIColor.primaryColor
        
        //aqui acontece a comunicação:
        //   usuário toca
        //   segmented muda índice
        //   chama segmentChanged
        control.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        
        return control
    }()
    
    @objc private func segmentChanged() {
        didTapSegmented?(segmentedControl.selectedSegmentIndex)
    }

    // MARK: - Stack horizontal que agrupa o nome e o tempo da receita
    private lazy var stackViewHorizontal: UIStackView = {
        lazy var stackView = UIStackView(arrangedSubviews: [recipeName, recipeTime])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.isLayoutMarginsRelativeArrangement = false
        stackView.distribution = .fill
        
        // recipeName cede espaço quando necessário
        recipeName.setContentHuggingPriority(.defaultLow, for: .horizontal)
        recipeName.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        // recipeTime nunca encolhe
        recipeTime.setContentHuggingPriority(.required, for: .horizontal)
        recipeTime.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        stackView.spacing = 10
        stackView.setContentHuggingPriority(.required, for: .horizontal)
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = .white

        setHierarchy()
        setConstraints()
    }
    
    func setHierarchy() {
        addSubview(recipeImage)
        addSubview(segmentedControl)
        addSubview(stackViewHorizontal)
        addSubview(sectionTitle)
    }
    
    
    
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
        
       
        
        // Carrefa a imagem
        if let url = URL(string: recipe.image) {
            recipeImage.load(url: url)
        }
    }
    
    
    
    func setConstraints() {
        // MARK: - Recipe image
        NSLayoutConstraint.activate([
            recipeImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            recipeImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            recipeImage.topAnchor.constraint(equalTo: topAnchor),
            recipeImage.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9)
        ])
        
        // MARK: - Stack Horizontal
        NSLayoutConstraint.activate([
            stackViewHorizontal.topAnchor.constraint(equalTo: recipeImage.bottomAnchor, constant: 16),
            stackViewHorizontal.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackViewHorizontal.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -16)
        ])
        
        // MARK: - Segmented Control
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: stackViewHorizontal.bottomAnchor, constant: 16),
            segmentedControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
        
        NSLayoutConstraint.activate([
            sectionTitle.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20),
            sectionTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            sectionTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            sectionTitle.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            sectionTitle.heightAnchor.constraint(greaterThanOrEqualToConstant: 18)
        ])
    }
}
