//
//  MyMainViewController.swift
//  CleanProtocolTableView
//
//  Created by Emincan on 13.09.2022.
//

import UIKit

class MyMainViewController: UIViewController {

    private var tableView: TableView = TableView()
    private var jsonService: JsonPlaceHolderService = JsonPlaceHolderService()
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setUp()
        initService()
    }

    private func setUp(){
        tableViewOutlet.delegate = tableView
        tableViewOutlet.dataSource = tableView
        tableView.delegate = self
        
    }
    private func initService() {
        jsonService.fethAllPosts { [weak self] (models) in
            self?.tableView.updateTable(items: models)
            self?.tableViewOutlet.reloadData()
        } onFail: { (data) in
            print(data ?? "")
        }
    }
    
}

extension MyMainViewController:tableViewOutput{
    func onSelected(item: PostModel) {
        print(item.body as Any )
    }
    
    
}
