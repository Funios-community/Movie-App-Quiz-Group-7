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
    
    private let viewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureGreetUserLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureGreetUserLabel()
    }
    
    private func configureGreetUserLabel() {
        if let username = viewModel.getUsername() {
            greetUserLabel.text = username.isEmpty ? "Hello" : "Hello, \(username)"
        }
    }
    
    @IBAction func onLogoutButtonTapped(_ sender: UIButton) {
        viewModel.logout()
        view.window?.rootViewController?.dismiss(animated: true, completion: { [weak self] in
            guard let self = self else { return }
            self.present(self.makeLoginViewController(), animated: true)
        })
    }
    
    private func makeLoginViewController() -> LoginViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController() as! LoginViewController
        viewController.modalPresentationStyle = .fullScreen
        return viewController
    }
}
