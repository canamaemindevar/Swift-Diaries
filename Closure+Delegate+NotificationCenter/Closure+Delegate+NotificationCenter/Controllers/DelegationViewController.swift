//
//  DelegationViewController.swift
//  Closure+Delegate+NotificationCenter
//
//  Created by Emincan on 14.09.2022.
//

import UIKit

protocol SelectionDelegate{
    func selection(name: String,image: UIImage,color:UIColor)
}

class DelegationViewController: UIViewController {

    var delegate: SelectionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func topBtnPressed(_ sender: UIButton) {
        delegate?.selection(name: "first", image:UIImage(named: "1")! , color: UIColor.blue)
        dismiss(animated: true)
    }
    
    @IBAction func bottomBtnPressed(_ sender: UIButton) {
        delegate?.selection(name: "second", image:UIImage(named: "2")! , color: UIColor.yellow)
        dismiss(animated: true)
    }
    

}
