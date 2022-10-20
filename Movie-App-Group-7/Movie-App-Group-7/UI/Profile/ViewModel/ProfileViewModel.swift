//
//  ProfileViewModel.swift
//  Movie-App-Group-7
//
//  Created by Mohammad Azri on 20/10/22.
//

import Foundation

class ProfileViewModel {
    func getUsername() -> String? {
        UserDefaultModel.instance.getUsername()
    }
    
    func logout() {
        UserDefaultModel.instance.logout()
    }
}
