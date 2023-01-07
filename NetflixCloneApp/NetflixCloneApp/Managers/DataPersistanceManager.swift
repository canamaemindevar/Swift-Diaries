//
//  DataPersistanceManager.swift
//  NetflixCloneApp
//
//  Created by Emincan on 16.07.2022.
//

import Foundation
import UIKit
import CoreData

class DataPersistanceManager {
    
    enum DatabaseError{
        case failedToSave
        case failToFetchData
        case failedToDeleteData
    }
    
    static let shared = DataPersistanceManager()
    
    func downloadTitleWith(model: Title, completion: @escaping(Result<Void,Error>) -> Void){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        
        let item = TitleItem(context: context)
        item.id = Int64(model.id)
        item.media_type = model.media_type
        item.original_name = model.original_name
        item.original_title = model.original_title
        item.overview = model.overview
        item.poster_path = model.poster_path
        item.release_date = model.poster_path
        item.vote_avarage = model.vote_avarage
        item.vote_count = Int64(model.vote_count)
        
        do {
            try context.save()
            completion(.success(()))
        } catch  {
            completion(.failure(DatabaseError.failedToSave as! Error))
                    }
    }
    
    func fetchingTitlefromDatabase(completion: @escaping(Result<[TitleItem],Error>) -> Void){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        
        let request: NSFetchRequest<TitleItem>
        request = TitleItem.fetchRequest()
        
        do {
           let titles = try context.fetch(request)
            completion(.success(titles))
        } catch  {
            print(error)
            completion(.failure(DatabaseError.failToFetchData as! Error))
        }
        
    }
    
    func deleteTitleWith(model:TitleItem, completion: @escaping(Result<Void,Error>) -> Void){
    
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
        return
    }
    let context = appDelegate.persistentContainer.viewContext
        
        context.delete(model)
        
        do {
            try context.save()
            completion(.success(()))
        } catch  {
            completion(.failure(DatabaseError.failedToDeleteData as! Error))
        }
        
    }
}

