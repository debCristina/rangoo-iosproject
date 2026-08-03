//
//  GroceryDetailTableViewCell.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 06/05/26.
//

import UIKit

// MARK: - Celula da table view dos itens da lista
class GroceryDetailTableViewCell: UITableViewCell, ViewProtocol {
    
    // MARK: - Variaveis de configuracoes
    var onButtonTapped: (() -> Void)?
    private var isChecked = false
    // Identificador da célula
    static let identifier: String = "GreceryDetailTableViewCell"
    
    // Titulo do item da lista
    private lazy var itemTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.customFont(type: .bold, size: 20)
        label.numberOfLines = 1
        label.textColor = UIColor.fontColor
        
        return label
    }()
    
    // Quantidade do item da lista
    private lazy var itemQuantityTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.customFont(type: .regular, size: 16)
        label.text = "Quantity:"
        label.numberOfLines = 1
        label.textColor = UIColor.fontColor
        return label
    }()
    
    private lazy var itemQuantityValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.customFont(type: .regular, size: 16)
        label.numberOfLines = 1
        
        label.textColor = UIColor.fontColor
        return label
    }()
    
    
    // Valor do item da lista
    private lazy var itemValueTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.customFont(type: .regular, size: 16)
        label.text = "Price:"
        label.numberOfLines = 1
        label.textColor = UIColor.fontColor
        return label
    }()
    
    // Valor do item da lista
    private lazy var itemValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.customFont(type: .regular, size: 16)
        label.numberOfLines = 1
        
        label.textColor = UIColor.fontColor
        return label
    }()
    
    // Unidade do item da lista
    private lazy var itemUnitTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.customFont(type: .regular, size: 16)
        label.text = "Unit:"
        label.numberOfLines = 1
        label.textColor = UIColor.fontColor
        return label
    }()
    
    // Unidade do item da lista
    private lazy var itemUnitValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.customFont(type: .regular, size: 16)
        label.numberOfLines = 1
        
        label.textColor = UIColor.fontColor
        return label
    }()
    
    // Stck que agrupa o o titulo da sessao de quantidade e o valor
    private lazy var quantityStackHorizontal: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [ itemQuantityTitle, itemQuantityValue])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 5
        stack.alignment = .leading
        return stack
    }()
    
    // Stck que agrupa o o titulo da sessao de quantidade e o valor
    private lazy var itemValueStackHorizontal: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [ itemValueTitle, itemValue])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 5
        stack.alignment = .leading
        return stack
    }()
    
    // Stck que agrupa o o titulo da sessao de quantidade e o valor
    private lazy var itemUnitStackHorizontal: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [ itemUnitTitle, itemUnitValue])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 5
        stack.alignment = .leading
        return stack
    }()
    
    // Stck que agrupa o titulo, quantidade e o valor
    private lazy var stackVertical: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [itemTitle, quantityStackHorizontal, itemValueStackHorizontal, itemUnitStackHorizontal])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 2
        stack.alignment = .leading
        return stack
    }()
    
    // Botão de check
    private lazy var checkButton: UIButton = {
        // Configura o botao com estilo visual simples
        var config = UIButton.Configuration.plain()
        
        // Configura o icone do botao
        config.image = UIImage(systemName: "circle")
        
        // Cria o botão com as configuracoes
        let button = UIButton(configuration: config)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        return button
    }()
    
    // Stack Horizontal que agrupa a stack vertical e o botão dwe check
    private lazy var stackHorizontal: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [stackVertical, checkButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .fill
        stackVertical.setContentHuggingPriority(.defaultLow, for: .horizontal)
        stackVertical.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        checkButton.setContentHuggingPriority(.required, for: .horizontal)
        return stack
    }()
    
    // MARK: - Método de inicialização
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        separatorInset = .zero
        
        layoutMargins = .zero
        
        preservesSuperviewLayoutMargins = false
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func configure(with item: ListItem) {
        itemTitle.text = item.name
        itemQuantityValue.text = "\(item.quantity)"
        itemValue.text = "\(item.price)"
        itemUnitValue.text = item.unit
    }
    
    // MARK: - Funcao que ativa a closure quando o botao é clicado
    @objc private func didTapButton() {
        isChecked.toggle()
        
        let imageIcon = isChecked ? "checkmark.circle.fill" : "circle"
        checkButton.setImage(UIImage(systemName: imageIcon), for: .normal)
        
    }
    
    // MARK: - Prepara o header para ser reutilizado sem nenhuma acao anterior de clique
    override func prepareForReuse() {
        super.prepareForReuse()
        onButtonTapped = nil
    }
    
    // MARK: - Seleciona o item
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    // MARK: - Configura a view
    func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    // MARK: - Adiciona os itens por hierarquia
    func setHierarchy() {
        contentView.addSubview(stackHorizontal)
    }
    
    // MARK: - Adiciona contraints
    func setConstraints() {
        NSLayoutConstraint.activate([
            stackHorizontal.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            stackHorizontal.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant:  16),
            stackHorizontal.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackHorizontal.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
}
