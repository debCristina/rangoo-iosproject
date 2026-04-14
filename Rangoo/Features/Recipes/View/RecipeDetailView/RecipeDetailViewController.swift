//
//  RecipeDetailViewController.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 13/04/26.
//

import Foundation
import  UIKit

// MARK: - View controller responsavel pela comunicacao entre view model -> view
class RecipeDetailViewController: UIViewController {
    
    // MARK: - Configura variáveis
    // View responsavel pela exibicao
    let recipeDetailView = RecipeDetailView()
    
    // View model responsavel por transmitir os dados
    
    
    // MARK: - Inicializacao da classe com a sua respectiva view model
    init() {

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuracoes para quando a view carregar
    override func viewDidLoad() {
        super.viewDidLoad()
        // Adiciona a view
        view = recipeDetailView
     
    }
}
