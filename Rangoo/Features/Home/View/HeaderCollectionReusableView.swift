//
//  CollectionReusableView.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 14/01/26.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView, ViewProtocol {
    
    
    static let identifier = "HeaderCollectionReusableView"
    
    private lazy var label: UILabel = {
        let label = UILabel()
//        label.text = "Categoria"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont.customFont(type: .semiBold, size: 18)
        
        return label
    }()
    
    private lazy var button: UIButton  = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage.buttonRight
        
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)

        return button
    } ()
    
    @objc private func didTapButton() {
        print("Botão clicado")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView() 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String) {
        label.text = title

    }

    func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    func setHierarchy() {
        addSubview(label)
        addSubview(button)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            button.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 8),
            button.centerYAnchor.constraint(equalTo: centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 20),
            button.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    
    
}
