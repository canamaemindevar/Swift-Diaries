//
//  ViewController.swift
//  hiddenPickerview
//
//  Created by Emincan on 13.08.2022.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var btn: UIButton!
    
    
    @IBOutlet weak var pickerView: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pickerView?.isHidden = true
        pickerView?.delegate = self
        pickerView?.dataSource = self
        tableview.isHidden = false
        setbarbutonitem()
        
        
    }
    @IBOutlet weak var tableview: UITableView!
    @IBAction func btn(_ sender: UIButton) {
        createPickerView()
        
    }
    
  
    
    
    
    
  @objc func createPickerView(){
        if pickerView?.isHidden == true{
            pickerView?.isHidden = false
            tableview.isHidden = true
        } else {
            pickerView?.isHidden = true
            tableview.isHidden = false

        }
        
        
   

        
    }

}

extension ViewController: UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 4
    }
    
    
}
extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}

extension ViewController {
    func setbarbutonitem(){
        let button = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.search, target: self, action: #selector(createPickerView))
        button.customView?.layer.borderWidth = 1
        button.customView?.backgroundColor = .yellow
        navigationItem.rightBarButtonItems = [button]
        
    }
}
