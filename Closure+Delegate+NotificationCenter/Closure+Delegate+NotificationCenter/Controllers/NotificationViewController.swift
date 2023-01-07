//
//  NotificationViewController.swift
//  Closure+Delegate+NotificationCenter
//
//  Created by Emincan on 14.09.2022.
//

import UIKit

class NotificationViewController: UIViewController {
    
    var notificationModel: [String:Any] = [
        "title": "",
        "image":UIImage(),
        "color":UIColor()
        ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func topBtnPressed(_ sender: UIButton) {
        notificationModel["title"] = "ay"
        notificationModel["image"] = UIImage(named: "ay")
        notificationModel["color"] = UIColor.orange
        //post
        NotificationCenter.default.post(name: Notification.Name(rawValue: "uniqueKey"),object: self ,userInfo: notificationModel)
        dismiss(animated: true)
        
    }
    
    @IBAction func bottomBtnpressd(_ sender: UIButton) {
        notificationModel["title"] = "saturn"
        notificationModel["image"] = UIImage(named: "saturn")
        notificationModel["color"] = UIColor.cyan
        //post
        NotificationCenter.default.post(name: Notification.Name(rawValue: "uniqueKey"),object: self ,userInfo: notificationModel)
        dismiss(animated: true)
    }
    
    
}
