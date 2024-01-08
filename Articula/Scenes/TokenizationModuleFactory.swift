//
//  TokenizationModuleFactory.swift
//  Articula
//
//  Created by Noor Walid on 08/01/2024.
//

import UIKit

protocol TokenizationModuleFactoryProtocol {
    func makeView() -> UIViewController
}

final class TokenizationModuleFactory {
    init() { }
}

extension TokenizationModuleFactory: TokenizationModuleFactoryProtocol {
    func makeView() -> UIViewController {
        let interactorDependencies = TokenizationInteractorDependencies(tokenizationService: TokenizationService())
        let interactor = TokenizationInteractor(dependencies: interactorDependencies)
        
        let presenterDependencies = TokenizationPresenterDependencies(interactor: interactor)
        let presenter = TokenizationPresenter(dependencies: presenterDependencies)
        
        let view = TokenizationViewController()
        
        view.presenter = presenter
        presenter.interactor = interactor
        return view
    }
}

private struct TokenizationInteractorDependencies: TokenizationInteractorDependenicesProtocol {
    var tokenizationService: TokenizationServiceProtocol
}

private struct TokenizationPresenterDependencies: TokenizationPresenterDependenciesProtocol {
    var interactor: TokenizationInteractorProtocol
}
