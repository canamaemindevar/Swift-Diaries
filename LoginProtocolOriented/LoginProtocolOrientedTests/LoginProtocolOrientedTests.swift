//
//  LoginProtocolOrientedTests.swift
//  LoginProtocolOrientedTests
//
//  Created by Emincan on 13.10.2022.
//

import XCTest
@testable import LoginProtocolOriented

class LoginProtocolOrientedTests: XCTestCase {
    
    private var viewModel: RootViewModel!
    private var loginStorageService: MockLoginStorageService!
    private var output: MockRootViewModelOutput!

    override func setUpWithError() throws {
        
        
        loginStorageService = MockLoginStorageService()
        viewModel = RootViewModel(loginStorageServiceInterface: loginStorageService)
        output = MockRootViewModelOutput()
        
        viewModel.output = output
    }

    override func tearDownWithError() throws {
        viewModel = nil
        loginStorageService = nil
    }

    func testShowLogin_whenLoginStorageReturnsEmptyUserAccesToken() throws {
        loginStorageService.mockStorage = [:]
        viewModel.checkLogin()
        
        XCTAssertEqual(output.checkArray.first,.login )
    }
    func testShowMainApp_whenLoginStorageReturnsEmptyString() throws {
        loginStorageService.mockStorage["ACCES_TOKEN"] = ""
        viewModel.checkLogin()
        
        XCTAssertEqual(output.checkArray.first, .login)
    }
    
    func testShowMainApp_whenLoginStorageReturnsUserAccesToken() throws {
        loginStorageService.mockStorage["ACCES_TOKEN"] = "afsafasfasfsaf"
        viewModel.checkLogin()
        
        XCTAssertEqual(output.checkArray.first, .mainApp)
    }
}

//MARK: Mocks

class MockLoginStorageService: LoginStorageServiceInterface{
    var userAccessToken: String {
        return "ACCES_TOKEN"
    }
    var mockStorage: [String : String] = [:]
    
    func setUserAccessToken(token: String) {
        mockStorage[userAccessToken] = token
    }
    
    func getUserAccesToken() -> String? {
        return mockStorage[userAccessToken]
    }
    
    
}

class MockRootViewModelOutput: RootViewModelOutput{
    
    enum Check{
        case login
        case mainApp
    }
    
    var checkArray: [Check] = []
    
    func showLogin() {
        checkArray.append(.login)
    }
    
    func showMainApp() {
        checkArray.append(.mainApp)
    }
}
