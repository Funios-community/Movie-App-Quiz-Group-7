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
        AuthSingleton.instance.logout()
        view.window?.rootViewController?.dismiss(animated: true, completion: { [weak self] in
            guard let self = self else { return }
            self.present(self.makeLoginViewController(), animated: true)
    } )
}
    private func makeLoginViewController() -> ViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let videoController =
            storyboard.instantiateInitialViewController() as! ViewController
            videoController.modalPresentationStyle = .fullScreen
            return videoController
    }
}
