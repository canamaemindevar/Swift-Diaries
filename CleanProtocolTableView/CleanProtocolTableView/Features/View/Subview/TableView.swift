//
//  JsonTableView.swift
//  CleanProtocolTableView
//
//  Created by Emincan on 13.09.2022.
//

import Foundation
import UIKit

protocol tableViewProtocol{
    func updateTable(items: [PostModel])
}
protocol tableViewOutput: AnyObject{
    func onSelected(item:PostModel)
}

final class TableView: NSObject{
    
    private lazy var items: [PostModel] = []
    
   weak var delegate: tableViewOutput?
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = UITableViewCell()
        
        cell.textLabel?.text = items[indexPath.row].title
        cell.detailTextLabel?.text = items[indexPath.row].body
                return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.onSelected(item: items[indexPath.row])
    }
}


extension TableView:UITableViewDelegate,UITableViewDataSource{}

extension TableView: tableViewProtocol{
    func updateTable(items: [PostModel]) {
        self.items = items
    }
    
    
}

