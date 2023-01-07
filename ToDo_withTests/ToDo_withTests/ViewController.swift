//
//  ViewController.swift
//  ToDo_withTests
//
//  Created by Emincan on 14.10.2022.
//

import UIKit

final class ViewController: UIViewController {
    
    var toDoList: [String] = []
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    @IBAction func addClicked(_ sender: UIBarButtonItem) {
        alertfunc()
    }
    
    func alertfunc(){
        let alert = UIAlertController(title: "Add New Task", message: "Enter Task", preferredStyle: .alert)
        alert.addTextField{ [weak self] textfield in
            textfield.placeholder = "Enter Task Here"
        }
        let okeyBtn = UIAlertAction(title: "OK", style: .default) { [weak self] action in
            guard let textfiled = alert.textFields?[0], let  inputText = textfiled.text, !inputText.isEmpty else {
                return
            }
            self?.toDoList.insert(inputText, at: 0)
            self?.table.insertRows(at: [.init(row: 0, section: 0)], with: .top)
        }
       alert.addAction(okeyBtn)
        self.present(alert, animated: true)
    }
    
}

//MARK: TableView DATA + DELEGATE

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        var context = cell.defaultContentConfiguration()
        context.text = toDoList[indexPath.row]
        cell.contentConfiguration = context
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.toDoList.remove(at: indexPath.row)
            table.deleteRows(at: [indexPath], with: .top)
        }
    }
    
    
}

extension ViewController: UITableViewDelegate{
    
}


