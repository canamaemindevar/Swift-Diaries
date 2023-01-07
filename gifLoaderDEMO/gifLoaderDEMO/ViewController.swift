//
//  ViewController.swift
//  gifLoaderDEMO
//
//  Created by Emincan on 17.12.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.imageView.image = UIImage.gifImageWithName("animasyon")
    }
    
    


}

