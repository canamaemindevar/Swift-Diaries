//
//  secondController.swift
//  artBooks
//
//  Created by Emincan on 21.06.2022.
//

import UIKit
import CoreData

class secondController: UIViewController{
    
    var choosenPainting: String?
    var choosenPaintingId: UUID?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var artistText: UITextField!
    @IBOutlet weak var yearText: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        showDetails()
        // for gestures
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        
        imageView.isUserInteractionEnabled = true
        let gestureRecImage = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(gestureRecImage)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        saveButton.isEnabled = true
        self.dismiss(animated: true)
    }
    
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    
    
}

//MARK: for picker and navigationcontroller

extension secondController: UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    
    @objc func selectImage(){
         let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
        
    }
}

//MARK: for core data

extension secondController {
    
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newPaintings = NSEntityDescription.insertNewObject(forEntityName: "Paintings", into: context)
        
        // Attributes
        newPaintings.setValue(nameText.text!, forKey: "name")
        newPaintings.setValue(artistText.text!, forKey: "artist")
        if let year = Int(yearText.text!){
        newPaintings.setValue(year, forKey: "year")
        }
        newPaintings.setValue(UUID(), forKey: "id")
        
        let imageData = imageView.image!.jpegData(compressionQuality: 0.5)
        newPaintings.setValue(imageData, forKey: "image")
        
        do {
            try context.save()
            print("succes")
        } catch {
            print("error")
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    // for get data
    func showDetails(){
        if choosenPainting != ""{
            
            saveButton.isHidden = true
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
            let idString = choosenPaintingId?.uuidString
            fetchReq.predicate = NSPredicate(format: "id = %@", idString!)
            
            do{
                let results = try context.fetch(fetchReq)
                
                if results.count>0{
                    for result in results as! [NSManagedObject] {
                        if let name = result.value(forKey: "name") as? String{
                            nameText.text = name
                        }
                        if let artist = result.value(forKey: "artist") as? String{
                            artistText.text = artist
                        }
                        if let year = result.value(forKey: "year") as? Int{
                            yearText.text = String(year)
                        }
                        if let imageData = result.value(forKey: "image") as? Data{
                            imageView.image = UIImage(data: imageData)
                        }
                    }
                }
                
            }catch{
                print(error.localizedDescription)
            }
            
            fetchReq.returnsObjectsAsFaults = false
            
        } else {
            saveButton.isHidden = false
            saveButton.isEnabled = false
        }
    }
    
    
}
