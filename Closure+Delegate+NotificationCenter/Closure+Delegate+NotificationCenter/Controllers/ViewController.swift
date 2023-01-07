//
//  ViewController.swift
//  Closure+Delegate+NotificationCenter
//
//  Created by Emincan on 14.09.2022.
//

import UIKit

class ViewController: UIViewController {
    


    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification), name: NSNotification.Name(rawValue: "uniqueKey"), object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    @objc  func handleNotification(notification: Notification){
        photoImage.image = notification.userInfo!["image"] as! UIImage
        nameLabel.text = notification.userInfo!["title"] as! String
        view.backgroundColor = notification.userInfo!["color"] as! UIColor
    }
    @IBAction func delegationBtnPressed(_ sender: UIButton) {
    let VC = storyboard?.instantiateViewController(withIdentifier: "DelegationViewController") as! DelegationViewController
        VC.delegate = self
    self.present(VC, animated: true)
    }
    
    @IBAction func notificationBtnPressed(_ sender: UIButton) {
        let VC = storyboard?.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
           
        self.present(VC, animated: true)
    }
    
    
//NotificationViewController
}

extension ViewController: SelectionDelegate{
    func selection(name: String, image: UIImage, color: UIColor) {
        self.photoImage.image = image
        self.nameLabel.text = name
        self.view.backgroundColor = color
        
    }
}
