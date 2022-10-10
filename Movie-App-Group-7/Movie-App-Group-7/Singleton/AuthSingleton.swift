//
//  AuthSingleton.swift
//  Movie-App-Group-7
//
//  Created by Nadia Darin on 11/10/22.
//

import Foundation

class AuthSingleton {
    private let loggedInUserDefaultsKey = "com.funios.loggedInkey"
    private let usernameUserdefaultsKey = "com.funios.usernameKey"

    static let instance = AuthSingleton()
    private let userDefaults: UserDefaults
    
    private init() {
        userDefaults = UserDefaults.standard
    }
    
    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
    
    func saveUserLogin(isLogin: Bool){
        userDefaults.set(isLogin, forKey: loggedInUserDefaultsKey)
    }
    
    func saveUserName(name: String) {
        userDefaults.set(name, forKey: usernameUserdefaultsKey)
    }
    
    func getUserLogin() -> Bool {
        return userDefaults.bool(forKey: loggedInUserDefaultsKey)
    }
    
    func getUserName() -> String? {
        return userDefaults.string(forKey: usernameUserdefaultsKey)
    }
    
    func logout() {
        AuthSingleton.instance.saveUserLogin(isLogin: false)
        AuthSingleton.instance.saveUserName(name: "")
    }
    
}


//(UserDefaults.standard.string(forKey: "com.funios.usernameKey")
