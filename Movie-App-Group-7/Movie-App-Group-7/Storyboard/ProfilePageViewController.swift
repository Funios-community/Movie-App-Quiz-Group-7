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
        
        helloLabel.text = "Hello, \(UserDefaults.standard.string(forKey: "com.funios.usernameKey")!)!"
        
    }
    
    @IBAction func logOutPressed(_ sender: Any) {
        removeLoginInformation()
        
        Switcher.updateRootViewController()
        
    }
    
    private func removeLoginInformation(){
        UserDefaults.standard.removeObject(forKey: "com.funios.loggedInkey")
        UserDefaults.standard.removeObject(forKey: "com.funios.usernameKey")
    }
    
    
    
    
}
