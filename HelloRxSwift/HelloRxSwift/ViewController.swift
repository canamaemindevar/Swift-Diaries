//
//  ViewController.swift
//  HelloRxSwift
//
//  Created by Emincan on 9.09.2022.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    let disposeBag = DisposeBag()

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var labelText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.slider.rx.value
            .subscribe(onNext:{
                self.labelText.text = "\($0)"
            }).disposed(by: disposeBag)
        
    }


}

