//
//  ListViewModel.swift
//  RxSwiftCarList
//
//  Created by Emincan on 20.09.2022.
//

import Foundation
import RxSwift
import RxCocoa

class ListViewModel {
    
    var listItems = PublishSubject<[ListModel]>()
    
    func fetchItems(){
        let items = [ListModel(model: "Model S", brand: "Tesla"),
                     ListModel(model: "320", brand: "Bmw"),
                     ListModel(model: "Gla", brand: "Mercedes"),
                     ListModel(model: "A4", brand: "Audi")]
        
        listItems.onNext(items)
    }
    
}
