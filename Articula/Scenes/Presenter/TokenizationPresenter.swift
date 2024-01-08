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

protocol TokenizationPresenterDependenciesProtocol {
    var interactor: TokenizationInteractorProtocol { get }
}

final class TokenizationPresenter {
    var interactor: TokenizationInteractorProtocol
    
    init(dependencies: TokenizationPresenterDependenciesProtocol) {
        self.interactor = dependencies.interactor
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
