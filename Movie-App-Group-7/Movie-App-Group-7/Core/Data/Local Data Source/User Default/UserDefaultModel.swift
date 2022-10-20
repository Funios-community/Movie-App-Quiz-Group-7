//
//  UserDefaultModel.swift
//  Movie-App-Group-7
//
//  Created by Mohammad Azri on 20/10/22.
//

import Foundation

class UserDefaultModel {
    private let loggedInUserDefaultsKey = "com.funios.loggedInkey"
    private let usernameUserDefaultsKey = "com.funios.usernameKey"

    static let instance = UserDefaultModel()
    private let userDefaults: UserDefaults
    
    private init() {
        userDefaults = UserDefaults.standard
    }
    
    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
    
    func login(username: String) {
        userDefaults.set(username, forKey: usernameUserDefaultsKey)
        userDefaults.set(true, forKey: loggedInUserDefaultsKey)
    }
    
    func isUserLoggedIn() -> Bool {
        userDefaults.bool(forKey: loggedInUserDefaultsKey)
    }
    
    func logout() {
        userDefaults.set("", forKey: usernameUserDefaultsKey)
        userDefaults.set(false, forKey: loggedInUserDefaultsKey)
    }
    
    func getUsername() -> String? {
        userDefaults.string(forKey: usernameUserDefaultsKey)
    }
}
