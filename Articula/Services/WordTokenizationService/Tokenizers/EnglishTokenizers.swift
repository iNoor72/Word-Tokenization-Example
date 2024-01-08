//
//  EnglishTokenizer.swift
//  Articula-Test-Project
//
//  Created by Noor Walid on 08/01/2024.
//

import Foundation

enum EnglishTokenizers: String, Tokenizers, CaseIterable {
    func getValue() -> String? {
        self.rawValue
    }
    
    case If = "if"
    case And = "and"
}
