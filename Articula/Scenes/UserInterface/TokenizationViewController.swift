//
//  ViewController.swift
//  Circula
//
//  Created by Noor Walid on 07/01/2024.
//

import UIKit
import NaturalLanguage

class TokenizationViewController: UIViewController {
    @IBOutlet private weak var translatedTextLabel: UILabel!
    @IBOutlet private weak var inputTextField: UITextField!
    
    private var presenter: TokenizationPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter = TokenizationPresenter()
    }
    
    private func setupUI() {
        inputTextField.delegate = self
        inputTextField.addTarget(self, action: #selector(self.inputTextFieldChanged(_:)), for: .editingChanged)
    }
    
    @objc private func inputTextFieldChanged(_ sender: UITextField) {
        guard let text = sender.text else { return }
        tokenizeText(text)
    }
    
    func tokenizeText(_ text: String) {
        guard let sentence = presenter.tokenizeSentence(text) else {
            translatedTextLabel.text = "Detecting text..."
            return
        }
        translatedTextLabel.text = sentence.joined(separator: "\n")
    }
}

extension TokenizationViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        tokenizeText(text)
    }
}
