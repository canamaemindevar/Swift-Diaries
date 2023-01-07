//
//  ViewController.swift
//  RxSwiftCarList
//
//  Created by Emincan on 20.09.2022.
//

import UIKit
import RxSwift
import RxCocoa
// bind
// fetch
// handle

class ViewController: UIViewController {

    @IBOutlet weak var table: UITableView!
    
    var viewModel = ListViewModel()
    
    var disposedBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTable()

    }

    
    fileprivate  func configureTable(){
        // TODO: binde table
        viewModel.listItems.bind(to: table.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self))
        { row, item,cell in
            cell.textLabel?.text = item.model
            cell.detailTextLabel?.text = item.brand
            
        }.disposed(by: disposedBag)
        // TODO: fetch items
        viewModel.fetchItems()
        
        // TODO: handle selection
    
        table.rx.modelSelected(ListModel.self).bind{ selectedItems in
            print("Selected Car is \(selectedItems.model), selected car's brand is \(selectedItems.brand)")
            
        }.disposed(by: disposedBag)
    }

}

