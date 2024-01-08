//
//  ViewController.swift
//  Circula
//
//  Created by Noor Walid on 07/01/2024.
//

import UIKit
import NaturalLanguage

class TokenizationViewController: UIViewController {
    
    let inTextField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        textField.placeholder = "Type here..."
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    let translationLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 300))
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.font = .systemFont(ofSize: 17)
        label.numberOfLines = 0
        
        return label
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var presenter: TokenizationPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        view.addSubview(translationLabel)
        view.addSubview(inTextField)
        setupUI()
    }
    
    private func setupUI() {
        translationLabel.translatesAutoresizingMaskIntoConstraints = false
        inTextField.translatesAutoresizingMaskIntoConstraints = false
        
        translationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        translationLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120).isActive = true
        translationLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32).isActive = true
        translationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        
        inTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 60).isActive = true
        inTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32).isActive = true
        inTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true

        inTextField.delegate = self
        inTextField.addTarget(self, action: #selector(self.inputTextFieldChanged(_:)), for: .editingChanged)
    }
    
    @objc private func inputTextFieldChanged(_ sender: UITextField) {
        guard let text = sender.text else { return }
        tokenizeText(text)
    }
    
    func tokenizeText(_ text: String) {
        guard let sentence = presenter.tokenizeSentence(text) else {
            translationLabel.text = "Detecting text..."
            return
        }
        translationLabel.text = sentence.joined(separator: "\n")
    }
}

extension TokenizationViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        tokenizeText(text)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return false
    }
}
