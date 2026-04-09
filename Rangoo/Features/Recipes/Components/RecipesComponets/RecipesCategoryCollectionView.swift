//
//  HomeCategoryButton.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 14/01/26.
//

import Foundation
import UIKit
import Combine

// MARK: - Classe responsável por configurar a Collection View
class RecipesCategoryCollectionView: UIView, ViewProtocol{
    // MARK: - Configuração de variáveis
    
    // Criando um objeto do tipo UICollectionView
    var recipesCollectionView: UICollectionView = {
        // chamando a funcao para criar o layout composicional
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.white
        collectionView.contentInsetAdjustmentBehavior = .never

        // Registrando a celula na collection
        collectionView.register(RecipeCategoryCollectionViewCell.self, forCellWithReuseIdentifier: RecipeCategoryCollectionViewCell.identifier)
        // Registrando o header na collection
        collectionView.register(HeaderCollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: HeaderCollectionReusableView.identifier)
        // Removendo a barra de scroll
        collectionView.showsHorizontalScrollIndicator = false

        return collectionView
    }()
    
    // MARK: - Função de inicialização
    override init(frame: CGRect) {
        super.init(frame: .zero)
        // Chama a função de configuração da view
        setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Função de setar os componentes
    func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    // MARK: - Função de organizar os elementos por hierarquia
    func setHierarchy() {
        addSubview(recipesCollectionView)
    }
    
    // MARK: - Função de configurar constraints
    func setConstraints() {
        NSLayoutConstraint.activate([
            recipesCollectionView.topAnchor.constraint(equalTo: topAnchor),
            recipesCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            recipesCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            recipesCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    // Funcao de criar o layout composicional
    private static func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnviroment) -> NSCollectionLayoutSection? in
            
            // ITEM (célula)
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            // GROUP (mesmo tamanho da célula + spacing)
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .estimated(140),
                heightDimension: .estimated(160)
            )
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitems: [item]
            )
            
            // SECTION
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.interGroupSpacing = CGFloat(Int.sectionSpacingInter)
            section.contentInsets = NSDirectionalEdgeInsets(
                top: 0,
                leading: CGFloat(Int.sectionSpacingLeading),
                bottom: 0,
                trailing: CGFloat(Int.sectionSpacingTrailing)
            )
            
            // Header
            let headerSize = NSCollectionLayoutSize(widthDimension:.fractionalWidth(1.0), heightDimension: .absolute(44))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            section.boundarySupplementaryItems = [header]
            
            return section
        }
        return layout
    }
}

