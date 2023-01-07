//
//  ViewController.swift
//  animate1
//
//  Created by Emincan on 28.11.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func button(_ sender: UIButton) {
        animate()
    }
    @IBOutlet weak var myView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    

    func animate(){
        UIView.animate(withDuration: 2) { // bütün animasyon süresi
            self.myView.transform = CGAffineTransform(rotationAngle: .pi/2)
        } completion: { _ in
            UIView.animate(withDuration: 0.5){ // alphayı 0 yapma süresi
                self.myView.alpha = 0
            }
        }
    }
}

