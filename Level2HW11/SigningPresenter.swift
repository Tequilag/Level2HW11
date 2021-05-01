//
//  SigningPresenter.swift
//  Level2HW11
//
//  Created by Andrey Buksha on 26.04.2021.
//

import Foundation

protocol SigningViewInput: AnyObject {
    
    func openSuccessModule()
    func show(error: Error)
    func setSignInButton(enabled: Bool)
}

class SigningPresenter {
    
    weak var view: SigningViewInput?
    
    private var email = ""
    private var password = ""
    private var regex: NSRegularExpression = {
        
        let specials = "$@$!%*#?&"
        let pattern = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[\(specials)])[A-Za-z\\d\(specials)]{6,}"
        guard let regex = try? NSRegularExpression(pattern: pattern) else { fatalError() }
        return regex
    }()
    
    private func isValid(password: String) -> Bool {
        
        return regex.firstMatch(in: password, range: NSRange(location: 0, length: password.count)) != nil
    }
    
}

extension SigningPresenter: SigningViewOutput {
    
    func viewDidLoad() {
        
        view?.setSignInButton(enabled: false)
    }
    
    func emailDidChange(_ email: String) {
        
        self.email = email
        updateSignInButtonState()
    }
    
    func passwordDidChange(_ password: String) {
        
        self.password = password
        updateSignInButtonState()
    }
    
    func signInButtonDidTap() {
        
        if email.isEmail && isValid(password: password) {
            
            view?.openSuccessModule()
        }
        else {
            
            view?.show(error: NSError(domain: "Invalid credentials", code: 1, userInfo: nil))
        }
    }
    
}

// MARK: - Private methods
private extension SigningPresenter {
    
    func updateSignInButtonState() {
        
        view?.setSignInButton(enabled: !(email.isEmpty || password.isEmpty))
    }
    
}
