//
//  ViewController.swift
//  ZarOyunu
//
//  Created by MacBook on 23.02.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var zarEkran2: UIImageView!
    
    @IBOutlet weak var zarEkran1: UIImageView!
    var imageArr = [UIImage(named: "zar1"),UIImage(named : "zar2"),UIImage(named : "zar3"),UIImage(named: "zar4"),UIImage(named: "zar5"),UIImage(named: "zar6")]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func zarAtBtn(_ sender: UIButton) {
        zarEkran1.image = imageArr[Int.random(in: 0...5)]
        zarEkran2.image = imageArr[Int.random(in: 0...5)]
    }
    

}

