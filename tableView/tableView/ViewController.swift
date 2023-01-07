//
//  ViewController.swift
//  tableView
//
//  Created by Emincan on 29.07.2022.
//

import UIKit

class ViewController: UIViewController {
   
    

      @IBOutlet weak var tableView: UITableView!
    
    enum Sections: Int, CaseIterable {
        case users = 0
        case planets
        case button
        
        var title: String {
            switch self {
            case .users:
                return "Users"
            case .planets:
                return "Planets"
            case .button:
                return "Switch Planet"
            }
        }
    }
    
    var imageNum = 0
    
    struct User {
        var name: String
        var number:String
    }
    
    let userList:[User] = [User(name: "User1", number: "1"),User(name: "User2", number: "2"),User(name: "User3", number: "3"),User(name: "User4", number: "4"),User(name: "User5", number: "5"),User(name: "User6", number: "6")]
    
    let images: [String] = ["ay","gunes","saturn"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    private func setupUI(){
        // cell register edilecek
       tableView.register(UINib(nibName: "UserTableViewCell", bundle: .main), forCellReuseIdentifier: "UserTableViewCell")
        tableView.register(UINib(nibName: "ImageCell", bundle: .main), forCellReuseIdentifier: "ImageCell")
        tableView.register(UINib(nibName: "ButtonCell", bundle: .main), forCellReuseIdentifier: "ButtonCell")
    }

    
}





extension ViewController: UITableViewDelegate,UITableViewDataSource {
    
    // header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sections = Sections(rawValue: section) else{
            return ""
        }
        switch sections {
        case .users:
            return Sections(rawValue: section)?.title
        case .planets:
            return Sections(rawValue: section)?.title
        case .button:
            return Sections(rawValue: section)?.title
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = Sections(rawValue: section) else{
            return 1
        }
        switch sections {
        case .users:
            return userList.count
        case .planets:
            return 1
        case .button:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sections = Sections(rawValue: indexPath.section) else{
            return UITableViewCell()
        }
        switch sections {
        case .users:
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as? UserTableViewCell
            cell?.configureCell(user: userList[indexPath.row].name, number: userList[indexPath.row].number)
            return cell ?? UITableViewCell()
        case .planets:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath) as? ImageCell
            cell?.configureImage(imageString: images[imageNum])
            return cell ?? UITableViewCell()
        case .button:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonCell", for: indexPath) as? ButtonCell
            cell?.delegate = self
            return cell ?? UITableViewCell()
        
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return Sections.allCases.count
    }
    
}

extension ViewController: buttonCellDelegate{
    func buttonPressed() {
        let numberArray = [0,1,2]
        let randomArray = numberArray.randomElement()
        self.imageNum = randomArray ?? 0
      //  tableView.reloadData()
        tableView.reloadSections(IndexSet(integer: 1), with: .left)
    }
}
