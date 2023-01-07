//
//  ViewController.swift
//  artBooks
//
//  Created by Emincan on 21.06.2022.
//

import UIKit
import CoreData

class ViewController: UIViewController {
   
    @IBOutlet weak var tableView: UITableView!
    
    var nameArray = [String]()
    var idArray = [UUID]()
    var selectedPainting: String?
    var selectedPaintingId: UUID?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(buttonTapped))
        
        getData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name(rawValue: "newData"), object: nil)
    }
    
    @objc func buttonTapped(){
        selectedPainting = ""
        performSegue(withIdentifier: "a", sender: nil)
    }

}

//MARK: tableView funcs

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = nameArray[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPainting = nameArray[indexPath.row]
        selectedPaintingId = idArray[indexPath.row]
        performSegue(withIdentifier: "a", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "a" {
            let destinationVc = segue.destination as! secondController
            destinationVc.choosenPainting = selectedPainting
            destinationVc.choosenPaintingId = selectedPaintingId
        }
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
                
            let idString = idArray[indexPath.row].uuidString
            fetchReq.predicate = NSPredicate(format: "id = %@", idString)
            fetchReq.returnsObjectsAsFaults = false
            
            do {
                let results = try context.fetch(fetchReq)
                if results.count>0 {
                    for result in results as! [NSManagedObject] {
                        
                        if let id = result.value(forKey: "id") as? UUID {
                            
                            if id == idArray[indexPath.row] {
                                context.delete(result)
                                nameArray.remove(at: indexPath.row)
                                idArray.remove(at: indexPath.row)
                                self.tableView.reloadData()
                                do{
                                try context.save()
                                }catch{
                                    
                                }
                                // break : if we dont work with id(its uniq) we can use with others
                            }
                            
                        }
                        
                        
                    }
                }
            } catch{
                print("error")
            }
            
        }
    }
    
    
}




//MARK: getting data from core data

extension ViewController {
   
   @objc func getData() {
       
       nameArray.removeAll(keepingCapacity: false)
       idArray.removeAll(keepingCapacity: false)
       
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
        fetchRequest.returnsObjectsAsFaults = false
        
        do{
       let results = try context.fetch(fetchRequest )
            if results.count>0{
                for result in results as! [NSManagedObject] {
                    if let name = result.value(forKey: "name") as? String {
                        self.nameArray.append(name)
                    }
                    if let id = result.value(forKey: "id") as? UUID {
                        self.idArray.append(id)
                    }
                    self.tableView.reloadData()
                }
            }
          
          } catch{
            
        }
    }
    
}
