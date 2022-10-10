//
//  ProfilePageViewController.swift
//  Movie-App-Group-7
//
//  Created by Nadia Darin on 24/08/22.
//

import Foundation
import UIKit

class ProfilePageViewController: UIViewController {
    
    var name: String?
    @IBOutlet weak var helloLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUsernameForHelloLabel()
    }
    
    @IBAction func logOutPressed(_ sender: Any) {
        AuthSingleton.instance.logout()
        
        Switcher.updateRootViewController()
        
    }
    
    private func getUsernameForHelloLabel(){
        if let username = AuthSingleton.instance.getUserName() {
            helloLabel.text = "Hello, \(String(describing: username))!)!"
        }
    }

}
