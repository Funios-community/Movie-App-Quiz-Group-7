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
        
        isUserAlreadyLoggedIn()
        view.isHidden = false
    }
    
    
    @IBAction func signInPressed(_ sender: Any) {
        let correctUser = checkCredential()
        
        if correctUser {
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SignInSegue" {
            if let barViewControllers = segue.destination as? UITabBarController {
                barViewControllers.viewControllers?.forEach({ controller in
                    if let profilePage = controller as? ProfilePageViewController {
                        profilePage.name = usernameTextField.text
                    }
                })
            }
            
        }
    }
    
    func checkCredential() -> Bool {
        usernameTextField.text == fakeUserName && passwordTextField.text == fakePassword
    }
    
    private func saveIsUserLoggeedIn(userLoginSuccesfully isLogin: Bool) {
        UserDefaults.standard.set(isLogin, forKey: loggedInUserDefaultsKey)
    }
    
    private func saveInputtedUsername(inputedUsername username: String) {
        let usernameUserdefaultsKey = "com.funios.usernameKey"
        UserDefaults.standard.set(username, forKey: usernameUserdefaultsKey)
    }
    
    private func isUserAlreadyLoggedIn() {
        if UserDefaults.standard.bool(forKey: loggedInUserDefaultsKey) {
            self.performSegue(withIdentifier: "SignInSegue", sender: self)
        }
    }
}

