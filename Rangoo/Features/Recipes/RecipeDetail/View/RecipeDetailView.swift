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
    let header = RecipeHeaderView()
    var onSegmentChanged: ((Int) -> Void)?
    
    let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        
        table.register(IngredientsTableViewCell.self,
                       forCellReuseIdentifier: IngredientsTableViewCell.identifier)
        
        table.register(InstructionsTableViewCell.self,
                       forCellReuseIdentifier: InstructionsTableViewCell.identifier)
        
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 100
        return table
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
        
        header.didTapSegmented = { [weak self] index in
            guard let self else { return }
            
            switch index {
            case 0:
                print("Ingredientes")
                self.onSegmentChanged?(index)
            case 1:
                print("Instruções")
                self.onSegmentChanged?(index)
            default:
                break
            }
        }
    }
    
    func setHierarchy() {
        addSubview(tableView)
    }

    private var headerConfigured = false
    
    
    private var lastWidth: CGFloat = 0
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard frame.width != lastWidth else { return }
        lastWidth = frame.width
        
        tableView.contentInset = UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: safeAreaInsets.bottom + 20,
            right: 0
        )
        guard !headerConfigured else { return }
        headerConfigured = true
        
        setupHeader()    }
    
    func setupHeader() {
        header.setNeedsLayout()
        
        header.layoutIfNeeded()
        let height = header.systemLayoutSizeFitting(
            CGSize(width: frame.width, height: UIView.layoutFittingCompressedSize.height),
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        ).height
        
        header.frame = CGRect(x: 0, y: 0, width: frame.width, height: height)
        tableView.tableHeaderView = header
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
            
        ])
    }
}
