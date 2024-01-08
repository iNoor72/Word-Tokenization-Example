//
//  TokenizationInteractor.swift
//  Articula-Test-Project
//
//  Created by Noor Walid on 08/01/2024.
//

import Foundation
import NaturalLanguage

protocol TokenizationInteractorDependenicesProtocol {
    var tokenizationService: TokenizationServiceProtocol { get }
}

protocol TokenizationInteractorProtocol {
    func getTokens(text: String) -> [String]
}

final class TokenizationInteractor: TokenizationInteractorDependenicesProtocol {
    var tokenizationService: TokenizationServiceProtocol
    
    init(dependencies: TokenizationInteractorDependenicesProtocol) {
        self.tokenizationService = dependencies.tokenizationService
    }
    
    private func detectLanguage(from sentence: String) -> String? {
        let recognizer = NLLanguageRecognizer()
        recognizer.processString(sentence)
        guard let languageCode = recognizer.dominantLanguage?.rawValue else { return nil }
        let detectedLanguage = Locale.current.localizedString(forIdentifier: languageCode)
        return detectedLanguage
    }

    private func getTokenizers(for language: SupportedLanguages) -> [String] {
        tokenizationService.getTokenizers(for: language)
    }

    private func getTokenizerValue(language: SupportedLanguages, for word: String) -> Tokenizers? {
        tokenizationService.getTokenizerValue(language: language, for: word)
    }
}

extension TokenizationInteractor: TokenizationInteractorProtocol {
    func getTokens(text: String) -> [String] {
        //1. Specify the text language
        let detectedLanguage = detectLanguage(from: text)
        let dominantLanguage = SupportedLanguages(rawValue: detectedLanguage ?? "") ?? .english
        
        //2. Split sentences to token words
        let sentenceWords = text.split(separator: " ").map { String($0) }
        
        var resultTokens = [String]()
        var normalWordsArray = [String]()
        
        //3. Extract tokens
        sentenceWords.forEach { word in
            guard
                let tokenizer = tokenizationService.getTokenizerValue(language: dominantLanguage, for: word),
                let tokenizerValue = tokenizer.getValue()
            else {
                normalWordsArray.append(word)
                return
            }
            
            guard !normalWordsArray.isEmpty else {
                resultTokens.append(tokenizerValue)
                return
            }
            resultTokens.append(normalWordsArray.joined(separator: " "))
            normalWordsArray = [tokenizerValue]
        }
        
        if !normalWordsArray.isEmpty { resultTokens.append(normalWordsArray.joined(separator: " ")) }
        return resultTokens
    }
}
