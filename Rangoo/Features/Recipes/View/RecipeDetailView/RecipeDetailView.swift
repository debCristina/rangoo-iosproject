//
//  RecipeDetailView.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 09/04/26.
//

import Foundation
import UIKit

// MARK: - Classe que exibe detalhes sobre a receita selecionada
class RecipeDetailView: UIView, ViewProtocol {
    
    // MARK: - Definicao de variaveis
    
    // View respnsável por exibir a lista de ingredientes
    private let ingredientsView = IngredientsView()
    
    // View responsavel por exibir as instruções dos ingredientes
    private let instructionsView = InstructionsView()
    
    // Sessões da segmented control que exibe opcoes de ingredientes e instrucoes
    private let segments = ["Ingredients", "Instructions"]
    
    // chamado quando usuário troca de aba exibindo ou ingredientes ou instrucoes
    @objc private func segmentChanged() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            showIngredients()
        case 1:
            showInstructions()
        default:
            break
        }
    }
    
    // MARK: - variavel de controle de estado
    private lazy var segmentedControl: UISegmentedControl = {
        // cria os botões com base nos segmentos
        let control = UISegmentedControl(items: segments)
        
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
        control.addTarget(self,
                          action: #selector(segmentChanged),
                          for: .valueChanged)
        return control
    }()
    
    // MARK: - Container que armazena as view de cada sessao
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    // MARK: - Imagem da receita
    private lazy var recipeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "recipeImage")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // MARK: - Nome da receita
    private lazy var recipeName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Strgonoff de Frango"
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
        label.text = "45 min"
        label.textColor = UIColor.fontColor
        label.font = UIFont.customFont(type: .regular, size: 14)
        return label
    }()
    
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
    
    
    // MARK: - Incializacao da view
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        showIngredients()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Funcao de configurar view
    func setupView() {
        setHierarchy()
        setConstraints()
        setupContainer()
    }
    
    // MARK: - Funcao de adicionar hierarquia
    func setHierarchy() {
        addSubview(recipeImage)
        addSubview(stackViewHorizontal)
        addSubview(segmentedControl)
        addSubview(containerView)

    }
    
    // MARK: - Funcao de adicionar constraints
    func setConstraints() {
        NSLayoutConstraint.activate([
            // MARK: - Recipe image
            //encosta no topo da tela
            recipeImage.topAnchor.constraint(equalTo: topAnchor),
            //ocupa toda largura
            recipeImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            recipeImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            //altura = 50% da tela
            recipeImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.50),
            
            // MARK: - Stack Horizontal
            // fica logo abaixo da imagem
            // com espaço de 16px
            stackViewHorizontal.topAnchor.constraint(equalTo: recipeImage.bottomAnchor, constant: 16),
            
            // começa 16px da esquerda
            stackViewHorizontal.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            // não força largura total
            // permite crescer só até onde precisar
            stackViewHorizontal.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -16),
            
            // MARK: - Segmented Control
            // fica abaixo do stack
            segmentedControl.topAnchor.constraint(equalTo: stackViewHorizontal.bottomAnchor, constant: 16),
            // ocupa quase toda largura com padding
            segmentedControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            // MARK: - Container do conteudo
            // começa abaixo do segmented
            containerView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 16),
            
            // ocupa toda largura
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            // cresce até o final da tela
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    // MARK: - Preparar o conteúdo interno da tela
    private func setupContainer() {
        
        // Adiciona ingredients e instrucoes dentro do container
        containerView.addSubview(ingredientsView)
        containerView.addSubview(instructionsView)
        
        // Configura a cor de fundo do container
        containerView.backgroundColor = .clear
        
        // Ativa o autolayout
        ingredientsView.translatesAutoresizingMaskIntoConstraints = false
        instructionsView.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: - Constraints do container
        NSLayoutConstraint.activate([
            // Ocupa todo o espaco
            ingredientsView.topAnchor.constraint(equalTo: containerView.topAnchor),
            ingredientsView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            ingredientsView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            ingredientsView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            // Ocupa todo o espaco
            instructionsView.topAnchor.constraint(equalTo: containerView.topAnchor),
            instructionsView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            instructionsView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            instructionsView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    
    // MARK: - Funcao dew exibir informacoes de ingredients
    private func showIngredients() {
        // exibe ingredients
        ingredientsView.isHidden = false
        // esconde as instrucoes
        instructionsView.isHidden = true
    }
    
    // MARK: - Funcao dew exibir informacoes de instrucoes
    private func showInstructions() {
        // Esconde ingredientes
        ingredientsView.isHidden = true
        
        // Exibe instrucoes
        instructionsView.isHidden = false
    }
    
}
