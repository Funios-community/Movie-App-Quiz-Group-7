//
//  Switcher.swift
//  Movie-App-Group-7
//
//  Created by Nadia Darin on 27/09/22.
//

import UIKit

class Switcher {
    
    static func updateRootViewController() {
        
        let status = UserDefaults.standard.bool(forKey: "com.funios.loggedInkey")
        var rootViewController : UIViewController?
        
        
        if (status == true) {
            let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
            let mainTabBarController = mainStoryBoard.instantiateViewController(withIdentifier: "MainTabID") as! UITabBarController
            rootViewController = mainTabBarController
        } else {
            let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
            let signInViewController = mainStoryBoard.instantiateInitialViewController() as! SignInViewController
            rootViewController = signInViewController
        }
        
        if let scene = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            scene.window?.rootViewController = rootViewController
        }
        
    }
    
}
