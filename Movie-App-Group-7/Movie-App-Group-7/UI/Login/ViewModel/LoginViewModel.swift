//
//  LoginViewModel.swift
//  Movie-App-Group-7
//
//  Created by Mohammad Azri on 18/10/22.
//

import Foundation

class LoginViewModel {
    
    func editTextValidation(usernameValue: String?, passwordValue: String?) -> Bool {
        guard let username = usernameValue else { return false }
        guard let password = passwordValue else { return false }
        
        if username.count < 4 || password.count < 4 {
            return false
        } else {
            return true
        }
    }
    
    func isAccountExist(username: String, password: String) -> Bool {
        if username == "azri" && password == "1234" {
            saveUserCredential(username)
            return true
        }
        
        return false
    }
    
    private func saveUserCredential(_ username: String) {
        UserDefaultModel.instance.login(username: username)
    }
}
