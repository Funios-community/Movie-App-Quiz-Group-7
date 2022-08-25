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
        let correctUser = checkCredential()
        
        if correctUser {
            
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
            let barViewControllers = segue.destination as! UITabBarController
            let profilePage = barViewControllers.viewControllers![1] as! ProfilePageViewController
            
            profilePage.name = usernameTextField.text
        }
    }
    
    func checkCredential() -> Bool {
        usernameTextField.text == fakeUserName && passwordTextField.text == fakePassword
    }
}

