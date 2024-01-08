//
//  TokenizersManager.swift
//  Articula-Test-Project
//
//  Created by Noor Walid on 08/01/2024.
//

import Foundation

protocol TokenizationServiceProtocol {
    func getTokenizers(for language: SupportedLanguages) -> [String]
    func getTokenizerValue(language: SupportedLanguages, for word: String) -> Tokenizers?
}

final class TokenizationService: TokenizationServiceProtocol {
    func getTokenizers(for language: SupportedLanguages) -> [String] {
        switch language {
        case .english:
            return EnglishTokenizers.allCases.map { $0.rawValue.lowercased() }
        case .spanish:
            return SpanishTokenizers.allCases.map { $0.rawValue.lowercased() }
        }
    }
    
    func getTokenizerValue(language: SupportedLanguages, for word: String) -> Tokenizers? {
        switch language {
        case .english:
            return EnglishTokenizers(rawValue: word)
        case .spanish:
            return SpanishTokenizers(rawValue: word)
        }
    }
}
