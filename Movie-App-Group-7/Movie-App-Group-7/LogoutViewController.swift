//
//  Logout.swift
//  Movie-App-Group-7
//
//  Created by Mac Pro on 27/08/22.
//

import Foundation
import UIKit

class LogoutViewController: UIViewController
{
    
    var name: String?
    
    @IBOutlet weak var labelLogout: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let name = name {
            labelLogout.text = "Hello \(name)"
            
        }
    }
    @IBAction func logoutButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
        
