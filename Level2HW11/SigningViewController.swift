//
//  SigningViewController.swift
//  Level2HW11
//
//  Created by Andrey Buksha on 26.04.2021.
//

import UIKit

protocol SigningViewOutput: AnyObject {
 
    func viewDidLoad()
    func emailDidChange(_ email: String)
    func passwordDidChange(_ password: String)
    func signInButtonDidTap()
}

class SigningViewController: UIViewController {
    
    // MARK: - Public properties
    
    lazy var output: SigningViewOutput = {
       
        let presenter = SigningPresenter()
        presenter.view = self
        return presenter
    }()
    
    // MARK: UI

    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let signInButton = UIButton()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        output.viewDidLoad()
    }

}

// MARK: - SigningViewInput
@objc extension SigningViewController: SigningViewInput {
    
    func setSignInButton(enabled: Bool) {
    
        signInButton.isEnabled = enabled
    }
    
    func openSuccessModule() {
        
        let alertController = UIAlertController(title: "Success", message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alertController, animated: true)
    }
    
    func show(error: Error) {
        
        let alertController = UIAlertController(title: "Error",
                                                message: error.localizedDescription,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alertController, animated: true)
    }
    
}

// MARK: - Private methods
private extension SigningViewController {
    
    func setupUI() {
        
        view.backgroundColor = .white
        
        let contentStackView = UIStackView()
        contentStackView.spacing = 16
        contentStackView.axis = .vertical
        
        emailTextField.placeholder = "Email"
        emailTextField.borderStyle = .roundedRect
        emailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        passwordTextField.placeholder = "Пароль"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        signInButton.clipsToBounds = true
        signInButton.isEnabled = false
        signInButton.setBackgroundImage(UIColor.gray.image(), for: .disabled)
        signInButton.setBackgroundImage(UIColor.blue.image(), for: .normal)
        signInButton.setTitle("Войти", for: .normal)
        signInButton.setTitleColor(.white, for: .normal)
        signInButton.setTitleColor(.darkGray, for: .disabled)
        signInButton.contentEdgeInsets = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
        signInButton.layer.cornerRadius = 8
        signInButton.addTarget(self, action: #selector(signInButtonDidTap(_:)), for: .touchUpInside)
        
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentStackView)
        for view in [emailTextField, passwordTextField, signInButton] {
            
            contentStackView.addArrangedSubview(view)
        }
        
        NSLayoutConstraint.activate([
        
            contentStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            contentStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 28),
            contentStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -28)
        ])
        emailTextField.accessibilityIdentifier = "emailTextField"
        passwordTextField.accessibilityIdentifier = "passwordTextField"
        signInButton.accessibilityIdentifier = "signInButton"
    }
    
}

// MARK: - Private methods
private extension SigningViewController {
    
    // MARK: Handlers
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        switch textField {
        case emailTextField:
            output.emailDidChange(textField.text ?? "")
        case passwordTextField:
            output.passwordDidChange(textField.text ?? "")
        default:
            break
        }
    }
    
    @objc func signInButtonDidTap(_ sender: UIButton) {
     
        output.signInButtonDidTap()
    }
    
}
