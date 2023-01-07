//
//  imageViewController.swift
//  kentUygulama
//
//  Created by Emincan on 7.06.2022.
//

import UIKit

protocol dataPassable{
    func dataPass(name: String, pic: UIImage)
}

class imageViewController: UIViewController {
//    func dataPass(name: String, pic: UIImage) {
//        <#code#>
//    }
    
    
     
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var selectedLandMarkName = ""
    var selectedLandMarkImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        
        label.text=selectedLandMarkName
        imageView.image = selectedLandMarkImage
    }
    



}
