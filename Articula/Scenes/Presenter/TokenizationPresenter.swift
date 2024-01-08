//
//  TokenizationPresenter.swift
//  Articula-Test-Project
//
//  Created by Noor Walid on 08/01/2024.
//

import Foundation
import NaturalLanguage

protocol TokenizationPresenterProtocol {
    func tokenizeSentence(_ sentence: String) -> [String]?
}

final class TokenizationPresenter {
    private let interactor: TokenizationInteractorProtocol
    
    init() {
        let tokenizationService = TokenizationService()
        let dependencies = TokenizationInteractorDependencies(tokenizationService: tokenizationService)
        interactor = TokenizationInteractor(dependencies: dependencies)
    }
    
    private func getTokens(text: String) -> [String]? {
        interactor.getTokens(text: text)
    }
}

extension TokenizationPresenter: TokenizationPresenterProtocol {
    func tokenizeSentence(_ sentence: String) -> [String]? {
        getTokens(text: sentence)
    }
}

private struct TokenizationInteractorDependencies: TokenizationInteractorDependenicesProtocol {
    var tokenizationService: TokenizationServiceProtocol
}
