//
//  HtmlToText.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 09/04/26.
//

import Foundation
import UIKit

extension String {
    var htmlToPlainText: String {
        guard let data = self.data(using: .utf8),
              let attributed = try? NSAttributedString(
                data: data,
                options: [.documentType: NSAttributedString.DocumentType.html],
                documentAttributes: nil
              ) else {
            return self
        }
        return attributed.string
    }
}
