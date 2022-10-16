//
//  ViewController.swift
//  Movie-App-Group-7
//
//  Created by PT.Koanba on 20/08/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var UserNameSignIn: UITextField!
    @IBOutlet weak var passwordSignIn: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    private let registeredUsername: String = "ana"
    private let registeredPassword: String = "yuhu"
//
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func SignInPressed(_ sender: UIButton) {
        let Username: String = UserNameSignIn.text?.lowercased() ?? ""
        let Password: String = passwordSignIn.text!
        
        let inputedUsername = UserNameSignIn.text
        let inputedPassword = passwordSignIn.text
        
        if inputedUsername == registeredUsername && inputedPassword == registeredPassword {
            saveIsUserLoggeedIn(userLoginSuccesfully: true)
            saveInputtedUsername(inputedUsername: inputedUsername!)
       
            perfomSegueToMovieList()
////
//            self.performSegue(withIdentifier: "SegueTabViewController", sender: nil)
//
//                // Do any additional setup if required.
//
//            func backAction(){
//                //print("Back Button Clicked")
//                dismiss(animated: true, completion: nil)
//            }
////            let alert = UIAlertController(title: "Yey anda benar", message: "Selamat Menonton", preferredStyle: .alert)
////            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
////            alert.addAction(okAction)
////            present(alert, animated: true, completion: nil)
        } else{
            createAlertWrongCredentials()
        }
    }
            private func createAlertWrongCredentials() {
                let alertTitle = "Wrong Credentials"
                let alertMessage = "Your username or password is wrong"
                let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                show(alert, sender: nil)
    }
    private func perfomSegueToMovieList() {
        performSegue(withIdentifier: "SegueTabViewController", sender: nil)
    }
    
    private func saveIsUserLoggeedIn(userLoginSuccesfully isLogin: Bool) {
        AuthSingleton.instance.saveUserLogin(isLogin: isLogin)
    }
    
    private func saveInputtedUsername(inputedUsername username: String) {
        AuthSingleton.instance.saveUserName(name: username)
    }
}

