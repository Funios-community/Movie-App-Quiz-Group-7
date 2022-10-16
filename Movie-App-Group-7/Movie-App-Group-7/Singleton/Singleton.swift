//
//  Singleton.swift
//  Movie-App-Group-7
//
//  Created by Mac Pro on 10/10/22.
//

import Foundation

class AuthSingleton {
    private let loggedInUserDefaultsKey = "com.funios.loggedInKey"
    private let usernameUserDefaultsKey = "com.funios.usenameInKey"
    
    static let instance = AuthSingleton()
    private let userDefaults: UserDefaults
    
    private init() {
        
        userDefaults = UserDefaults.standard
        }
    
    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
    
    func saveUserLogin(isLogin: Bool) {
        userDefaults.set(isLogin, forKey: loggedInUserDefaultsKey)
    }
    
    func saveUserName(name: String) {
        userDefaults.set(name, forKey: usernameUserDefaultsKey)
        
    }

func getUserLogin() -> Bool {
    return userDefaults.bool(forKey: loggedInUserDefaultsKey)
}
    
    func getUserName() -> Bool {
        return userDefaults.bool(forKey: usernameUserDefaultsKey)
    }
    
    func logout() {
        AuthSingleton.instance.saveUserLogin(isLogin: false)
        AuthSingleton.instance.saveUserName(name: "" )
        
    }
    
}
