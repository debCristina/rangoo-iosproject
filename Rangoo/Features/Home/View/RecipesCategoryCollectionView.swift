//
//  HomeCategoryButton.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 14/01/26.
//

import Foundation
import UIKit

enum SectionKind: Int, CaseIterable {
    case popular
    case recent
    case favorites
    
    var sectionTitle: String {
        switch self {
        case .popular: return "Popular"
        case .recent: return "Recentes"
        case .favorites: return "Favoritos"
        }
    }
}

class RecipesCategoryCollectionView: UIView, ViewProtocol {
   
    
    // Criando um objeto do tipo UICollectionView
    private var recipesCollectionView: UICollectionView = {
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
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Funcao de seta os componentes
    func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setupCollectionView() {
        recipesCollectionView.dataSource = self
        recipesCollectionView.delegate = self
    }
    
    func setHierarchy() {
        setupCollectionView()
        addSubview(recipesCollectionView)
    }
    
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
            section.interGroupSpacing = 30
            section.contentInsets = NSDirectionalEdgeInsets(
                top: 0,
                leading: 16,
                bottom: 0,
                trailing: 16
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

// Extensão da view controller que será utilizado como data source
extension RecipesCategoryCollectionView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // Método que informa quantos elementos vamos ter em cada seção
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionKind = SectionKind(rawValue: section)!
        
        switch sectionKind {
        case .popular:
            return 10
        case .recent:
            return 6
        case .favorites:
            return 4
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        SectionKind.allCases.count
    }
    
    // Função de informa qual celula irá aparecer em cada posição
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Solicita à collection view uma célula reutilizável registrada anteriormente usando o identificador da HourlyForecastCollectionViewCell.
        // Se existir uma célula fora da tela disponível na fila de reutilização, ela será reaproveitada; caso contrário, uma nova célula será criada.
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeCategoryCollectionViewCell.identifier, for: indexPath)
        
        
        // Neste ponto, a célula já existe (nova ou reutilizada), mas ainda NÃO está configurada com dados específicos.
        // Normalmente aqui chamaria um método como configure(...) para preencher labels, imagens e estados visuais da célula.
        // Retorna a célula para que a collection view possa posicioná-la e exibi-la na tela no indexPath informado.
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier, for: indexPath) as! HeaderCollectionReusableView
        
        let sectionKind = SectionKind(rawValue: indexPath.section)
        header.configure(title: sectionKind?.sectionTitle ?? "")
        return header
    }
}
