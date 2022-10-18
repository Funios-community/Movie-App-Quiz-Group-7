//
//  ProfileViewController.swift
//  Movie-App-Group-7
//
//  Created by Mohammad Azri on 18/10/22.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet private weak var greetUserLabel: UILabel!
    @IBOutlet private weak var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onLogoutButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
