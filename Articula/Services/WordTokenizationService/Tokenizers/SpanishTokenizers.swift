//
//  SpanishTokenizer.swift
//  Articula-Test-Project
//
//  Created by Noor Walid on 08/01/2024.
//

import Foundation

enum SpanishTokenizers: String, Tokenizers, CaseIterable {
    func getValue() -> String? {
        self.rawValue
    }
    
    case If = "si"
    case And = "y"
}
