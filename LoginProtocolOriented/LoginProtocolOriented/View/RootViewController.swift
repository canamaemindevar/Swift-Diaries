//
//  ViewController.swift
//  LoginProtocolOriented
//
//  Created by Emincan on 13.10.2022.
//

import UIKit



class RootViewController: UIViewController {
    
    private var viewModel: RootViewModel
    
    init(viewModel:RootViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.output = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .red
        viewModel.checkLogin()
        
    }
    // protocoldan gelen
    func showLogin() {
        let loginViewController = LoginViewController()
        navigationController?.present(loginViewController, animated: true)
    }
    
    func showMainApp() {
        let mainViewController = MainViewController()
        navigationController?.present(mainViewController, animated: true)
    }
  
}
extension RootViewController:RootViewModelOutput{}

