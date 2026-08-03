//
//  ViewProtocol.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 14/01/26.
//
import UIKit

// MARK: - Protocolo que todas as views devem conformar
protocol ViewProtocol {
    func setupView()
    func setHierarchy()
    func setConstraints()
}
