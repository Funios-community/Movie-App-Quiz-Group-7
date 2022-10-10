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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signInPressed(_ sender: Any) {
        if validCredential {
            saveIsUserLoggeedIn(userLoginSuccesfully: true)
            
            saveInputtedUsername(inputedUsername: usernameTextField.text!)
            
            performSignInSegue()
            
        } else {
            showFailedSignInAlert()
        }
    }
    
    private func performSignInSegue(){
        self.performSegue(withIdentifier: "SignInSegue", sender: self)
    }
    
    private var validCredential: Bool {
        self.usernameTextField.text == self.fakeUserName && self.passwordTextField.text == self.fakePassword
    }
    
    private func saveIsUserLoggeedIn(userLoginSuccesfully isLogin: Bool) {
        AuthSingleton.instance.saveUserLogin(isLogin: isLogin)
    }
    
    private func saveInputtedUsername(inputedUsername username: String) {
        AuthSingleton.instance.saveUserName(name: username)
    }
    
    private func showFailedSignInAlert(){
        let alertDialog = UIAlertController(title: "Failed", message: "Wrong Credentials", preferredStyle: .alert)
        
        let actionButton = UIAlertAction(title: "Ok", style: .default)
        alertDialog.addAction(actionButton)
        
        self.present(alertDialog, animated: true)
    }
    
}

