//
//  SearchController.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 14/01/26.
//

import Foundation
import UIKit

final class SearchController {
    
    static func make() -> UISearchController {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.searchBarStyle = .minimal
        searchController.obscuresBackgroundDuringPresentation = false
        return searchController
    }
}
