//
//  ViewController.swift
//  MvvmRxSwiftLogin
//
//  Created by Emincan on 9.09.2022.
//

import UIKit
import RxCocoa
import RxSwift


class ViewController: UIViewController {
    
    private let loginViewModel = LoginViewModel()
    private let disposeBag = DisposeBag()

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var mailTextFiled: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mailTextFiled.becomeFirstResponder()
        
        mailTextFiled.rx.text.map {$0 ?? ""}.bind(to:loginViewModel.mailtextPublishSubject).disposed(by: disposeBag)
        PasswordTextField.rx.text.map {$0 ?? ""}.bind(to:loginViewModel.passwordTextPublishSubject).disposed(by: disposeBag)
        loginViewModel.isValid().bind(to: loginButton.rx.isEnabled).disposed(by: disposeBag)
        loginViewModel.isValid().map {$0 ? 1: 0.1 }.bind(to: loginButton.rx.alpha).disposed(by: disposeBag)
    }


    @IBAction func loginBtnPressed(_ sender: UIButton) {
    }
}

class LoginViewModel{
    let mailtextPublishSubject = PublishSubject<String>()
    let passwordTextPublishSubject = PublishSubject<String>()
    
    func isValid() -> Observable<Bool> {
        return Observable.combineLatest(mailtextPublishSubject.asObserver().startWith(""), passwordTextPublishSubject.asObserver().startWith("")) { mail,password in
            return mail.count > 3 && password.count > 3
        }.startWith(false)
    }
    
}
