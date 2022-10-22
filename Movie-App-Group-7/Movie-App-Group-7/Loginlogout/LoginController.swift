//
//  LoginController.swift
//  Movie-App-Group-7
//
//  Created by Agung Luo on 26/08/22.
//

import Foundation
import UIKit

class LoginController: UIViewController {
    //properties for part of login page
    @IBOutlet var UsernameTextField: UITextField!
    @IBOutlet var PasswordTextField: UITextField!
    
    //Credential Data for login
    let MyUsername = "Agungluo"
    let MyPassword = "abcde"
    // Implementasi checkbox untuk di checklist
    
    @IBOutlet weak var rememberCheckBox: UIButton!
    var isCheckMark = true
    
    
    @IBAction func VerifyMethod(_ sender: Any)
    {
        if UsernameTextField.text == MyUsername && PasswordTextField.text == MyPassword {
            AuthSingleton.instance.saveUserLogin(isLogin: true)
            performSegue(withIdentifier: "VerifiedSegue", sender: nil)
            
        } else {
            let alert = UIAlertController(
                title: "Alert",
                message: "Message",
                preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        checkMarkTapped(rememberCheckBox)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        isUserAlreadyLoggedIn()
    }
    
    //MARK: - Login Function List
    func perfomSegueToMovieList() {
        performSegue(withIdentifier: "VerifiedSegue", sender: nil)
    }
    func isUserAlreadyLoggedIn() {
        if AuthSingleton.instance.getUserLogin() {
            perfomSegueToMovieList()
        }
    }
    func saveIsUserLoggedIn(userLoginSuccessfully isLogin: Bool) {
        AuthSingleton.instance.saveUserLogin(isLogin: isLogin)
    }
    func saveInputtedUsername(inputedUsername username: String) {
        AuthSingleton.instance.saveUserName(name: username)
    }
    //MARK: - checkMarkTapped
    @IBAction func checkMarkTapped(_ sender: UIButton) {
        if isCheckMark {
            sender.setImage(UIImage(systemName: "square"), for: .normal)
            isCheckMark = false
        } else {
            sender.setImage(UIImage(systemName: "checkmark.square "), for: .normal)
            isCheckMark = true
        }
        //lanjutan implementasi CheckboxReminder
        //nah ketika checklist, maka akan menyimpan username dan password. sehingga tinggal di tap signin, namun ketika logout username dan password sudah terisi
        
        
    }
    
    
}
