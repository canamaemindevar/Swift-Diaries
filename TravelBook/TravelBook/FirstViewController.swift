//
//  FirstViewController.swift
//  TravelBook
//
//  Created by Emincan on 24.06.2022.
//

import UIKit
import CoreData

class FirstViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var titleArray = [String]()
    var idArray = [UUID]()
    
    var choosenTitle: String?
    var choosenTitleId: UUID?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButton))
        getData()
        
       
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector (getData), name: NSNotification.Name("newPlace"), object: nil)
    }
    
    @objc func addButton(){
        performSegue(withIdentifier: "toSecondVc", sender: nil)
    }

   @objc func getData(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Places")
        request.returnsObjectsAsFaults = false
        do{
            let results = try context.fetch(request)
            if results.count>0{
                idArray.removeAll(keepingCapacity: false)
                titleArray.removeAll(keepingCapacity: false)
                for result in results as![NSManagedObject]{
                    if let title =  result.value(forKey: "title") as? String{
                        self.titleArray.append(title)
                    }
                    if let id =  result.value(forKey: "id") as? UUID{
                        self.idArray.append(id)
                    }
                    tableView.reloadData()
                }
            }
        } catch{
            print("error")
        }
    }
    

}

extension FirstViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = titleArray[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        choosenTitle = titleArray[indexPath.row]
        choosenTitleId = idArray[indexPath.row]
        performSegue(withIdentifier: "toSecondVc", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSecondVc" {
            let destinationVc = segue.destination as! ViewController
            destinationVc.selectedTitle = choosenTitle!
            destinationVc.selectedTitleId = choosenTitleId
        }
    }
}
