//
//  ViewController.swift
//  Movie-App-Group-7
//
//  Created by PT.Koanba on 20/08/22.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    private let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordTextField.isSecureTextEntry = true
        resetView()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        resetView()
    }
    
    @IBAction func editingUsernameTextField(_ sender: UITextField) {
        signInButton.isEnabled = viewModel.editTextValidation(usernameValue: usernameTextField.text, passwordValue: passwordTextField.text)
    }
    
    @IBAction func editingPasswordTextField(_ sender: UITextField) {
        signInButton.isEnabled = viewModel.editTextValidation(usernameValue: usernameTextField.text, passwordValue: passwordTextField.text)
    }
    
    @IBAction func onSignInButtonTapped(_ sender: UIButton) {
        if viewModel.isAccountExist(username: usernameTextField.text ?? "", password: passwordTextField.text ?? "") {
            let vc = storyboard?.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        } else {
            showDialog()
        }
    }
    
    private func showDialog() {
        let alert = UIAlertController(title: "Failed", message: "Wrong Credentials", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func resetView() {
        usernameTextField.text = ""
        passwordTextField.text = ""
        signInButton.isEnabled = false
    }
}

