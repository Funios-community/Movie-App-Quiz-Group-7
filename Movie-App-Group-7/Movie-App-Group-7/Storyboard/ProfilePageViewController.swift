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
        
        if let name = name {
            helloLabel.text = "Hello, \(name)!"
        }
    }

    @IBAction func logOutPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
