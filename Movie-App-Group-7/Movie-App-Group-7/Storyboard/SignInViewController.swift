//
//  SignInViewController.swift
//  Movie-App-Group-7
//
//  Created by Nadia Darin on 24/08/22.
//

import Foundation
import UIKit

class SignInViewController: UIViewController {
    
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let fakeUserName = "Darin"
    let fakePassword = "123456"
    
    private let loggedInUserDefaultsKey = "com.funios.loggedInkey"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        view.isHidden = false
    }
    
    
    @IBAction func signInPressed(_ sender: Any) {
        
        if validCredential {
            saveIsUserLoggeedIn(userLoginSuccesfully: true)
            saveInputtedUsername(inputedUsername: usernameTextField.text!)
            
            self.performSegue(withIdentifier: "SignInSegue", sender: self)
            
        } else {
            
            let alertDialog = UIAlertController(title: "Failed", message: "Wrong Credentials", preferredStyle: .alert)
            let actionButton = UIAlertAction(title: "Ok", style: .default)
            alertDialog.addAction(actionButton)
            
            self.present(alertDialog, animated: true)
        }
    }
    
    private var validCredential: Bool {
        self.usernameTextField.text == self.fakeUserName && self.passwordTextField.text == self.fakePassword
    }
    
    private func saveIsUserLoggeedIn(userLoginSuccesfully isLogin: Bool) {
        UserDefaults.standard.set(isLogin, forKey: loggedInUserDefaultsKey)
    }
    
    private func saveInputtedUsername(inputedUsername username: String) {
        let usernameUserdefaultsKey = "com.funios.usernameKey"
        UserDefaults.standard.set(username, forKey: usernameUserdefaultsKey)
    }
    
}

