//
//  String.swift
//  Articula-Test-Project
//
//  Created by Noor Walid on 08/01/2024.
//

import Foundation
extension String {
    func localized() -> String {
        return NSLocalizedString(
            self,
            tableName: "Localizable",
            bundle: .main,
            value: self,
            comment: self
        )
    }
}
