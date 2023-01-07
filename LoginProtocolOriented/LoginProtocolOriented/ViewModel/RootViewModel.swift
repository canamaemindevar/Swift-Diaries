//
//  RootViewModel.swift
//  LoginProtocolOriented
//
//  Created by Emincan on 13.10.2022.
//

import Foundation

protocol RootViewModelOutput: AnyObject{
    func showLogin()
    func showMainApp()
}

class RootViewModel{
    
    private let loginStorageServiceInterface: LoginStorageServiceInterface
    weak var output: RootViewModelOutput?
    
    init(loginStorageServiceInterface: LoginStorageServiceInterface) {
       
        self.loginStorageServiceInterface = loginStorageServiceInterface
    }
    
    func checkLogin(){
        if let accessToken = loginStorageServiceInterface.getUserAccesToken(), !accessToken.isEmpty{
          //  showMainApp()
            output?.showMainApp()
        }else{
         //   showLogin()
            output?.showLogin()
        }
    }
}
