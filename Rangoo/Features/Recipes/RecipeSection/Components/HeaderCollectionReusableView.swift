//
//  CollectionReusableView.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 14/01/26.
//

import UIKit
import Combine

// MARK: - Header utilizado para nomear as diferentes sessoes da collection view
class HeaderCollectionReusableView: UICollectionReusableView, ViewProtocol {
    
    // MARK: - Configuração das variaveis
    
    // Identificador do titulo
    static let identifier = "HeaderCollectionReusableView"
    
    //Um canal que emite eventos sem dados e nunca dá erro
    let buttonTapped = PassthroughSubject<Void, Never>()
    
    // Closure para comunicar o toque no botao
    var onButtonTapped: (() -> Void)?

    // Titulo da sessao
    private lazy var sectionTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont.customFont(type: .semiBold, size: 18)
        
        return label
    }()
    
    // Botao do header
    private lazy var button: UIButton  = {
        
        // Configura o botao com estilo visual simples
        var config = UIButton.Configuration.plain()
        
        // Configura o icone do botao
        config.image = UIImage.buttonRight
        
        // Cria o botao com as configuracoes
        let button = UIButton(configuration: config)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        // Ligar o clique do botão a uma função.
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)

        return button
    } ()
    
    // MARK: - Inicializacao do header chamando setup view
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Funcao que ativa a closure quando o botao é clicado
    @objc private func didTapButton() {
        onButtonTapped?()
    }
    
    // MARK: - Prepara o header para ser reutilizado sem nenhuma acao anterior de clique
    override func prepareForReuse() {
        super.prepareForReuse()
        onButtonTapped = nil
    }
    
    // MARK: - Configura o título da sessao com o valor recebido pela api
    func configure(title: String) {
        sectionTitle.text = title
    }
    
    // MARK: - Setup View
    func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    // MARK: - Adiciona as views em ordem de hierarquia
    func setHierarchy() {
        addSubview(sectionTitle)
        addSubview(button)
    }
    
    // MARK: - Configura as constraints
    func setConstraints() {
        NSLayoutConstraint.activate([
            sectionTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            sectionTitle.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            button.leadingAnchor.constraint(equalTo: sectionTitle.trailingAnchor, constant: 8),
            button.centerYAnchor.constraint(equalTo: centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 20),
            button.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        // A sectionTitle prefere não crescer horizontalmente além do necessário
        sectionTitle.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        sectionTitle.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
}
