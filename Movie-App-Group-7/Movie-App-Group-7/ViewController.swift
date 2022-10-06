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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func SignInPressed(_ sender: UIButton) {
        let Username: String = UserNameSignIn.text?.lowercased() ?? ""
        let Password: String = passwordSignIn.text!
        
        if Username.isEmpty || Password.isEmpty {
            print ("Username / Password is zonk!")
            
            return;
        }
        if (Username == "a") && (Password == "b") {
//            guard let landingVC = segue.destination as? ViewController else{ return}
//            if let Username = Username, let Password = Password {
//                landingVC.UserNameSignIn = Username + " " + Password
//                }
//            
            self.performSegue(withIdentifier: "SegueTabViewController", sender: nil)
            
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
            let alert = UIAlertController(title: "Failed", message: "Wrong Credentials", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueTabViewController" {
            if let tabBarViewController = segue.destination as?  UITabBarController {
                tabBarViewController.viewControllers?.forEach({ conttroler in
                    if let logout = conttroler as? LogoutViewController {
                        logout.name = UserNameSignIn.text
                    }
                })
                
            }
        }
        
    }
}
