//
//  ViewController.swift
//  kentUygulama
//
//  Created by Emincan on 7.06.2022.
//

import UIKit




class ViewController: UIViewController {
    var landmarkNames=[String]()
    var landmarkImages=[UIImage]()
    var chosenLandMarkName = ""
    var chosenLandMarkImage = UIImage()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        
        // açılınca veriyi burdan eklemsi lazım
        landmarkNames.append("kolezyum")
        landmarkNames.append("cinseddi")
        landmarkNames.append("kremlin")
        landmarkNames.append("stonehenge")
        landmarkNames.append("tacmahal")
        landmarkImages.append(UIImage(named:"kolezyum")!)
        landmarkImages.append(UIImage(named:"cinseddi")!)
        landmarkImages.append(UIImage(named:"kremlin")!)
        landmarkImages.append(UIImage(named:"stonehenge")!)
        landmarkImages.append(UIImage(named:"tacmahal")!)
    }
  

}

extension ViewController :UITableViewDelegate{
    
}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return landmarkNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text=landmarkNames[indexPath.row]
        return cell
    }
}
    

extension ViewController {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenLandMarkName = landmarkNames[indexPath.row]
        chosenLandMarkImage = landmarkImages[indexPath.row]

        performSegue(withIdentifier: "toSecondVc", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSecondVc"{
            let destinationVC = segue.destination as! imageViewController
            destinationVC.selectedLandMarkName = chosenLandMarkName
            destinationVC.selectedLandMarkImage = chosenLandMarkImage
            
        }
    }
}
