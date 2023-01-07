//
//  LoginStorageService.swift
//  LoginProtocolOriented
//
//  Created by Emincan on 13.10.2022.
//

import Foundation

protocol LoginStorageServiceInterface{
    var userAccessToken: String {get}
    func setUserAccessToken(token: String)
    func getUserAccesToken() -> String?
}

class LoginStorageService: LoginStorageServiceInterface{
    
    private let storage = UserDefaults.standard
    
    var userAccessToken: String {
        return "ACCESS_TOKEN"
    }
    
    func setUserAccessToken(token: String) {
        storage.set(token, forKey: userAccessToken)
    }
    
    func getUserAccesToken() -> String? {
        
        return storage.string(forKey: userAccessToken)
    }
    
    
}
