//
//  ViewController.swift
//  MovieApp
//
//  Created by Emincan on 9.12.2022.
//

import UIKit

class MainPageViewController: UIViewController {
    
    @IBOutlet weak var segment: UISegmentedControl!
    
    @IBOutlet weak var collection: UICollectionView!
    
    lazy var myViewModel = MainPageViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        design()
        setup()
        layout()
        
    }
    
    lazy var masterarray = myViewModel.movies
    
    
    
    private func design() {
        
        view.backgroundColor = .systemGreen
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .systemYellow
       
        
    }
    
    private func setup() {
        collection.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        segment.addTarget(self, action: #selector(handleSegmentChange), for: .valueChanged)
        layoutFunc()
    }
    
    private func layout() {
        
    }
    
    
    @objc fileprivate  func handleSegmentChange() {
        print(segment.selectedSegmentIndex)
        
        switch segment.selectedSegmentIndex {
        case 0:
            masterarray = myViewModel.movies
            
        case 1:
            masterarray = myViewModel.tvShows
            
        case 2:
            masterarray = myViewModel.upcoming
            
        default:
            masterarray = myViewModel.movies
            
        }
        collection.reloadData()
    }
}

//MARK: collectionview funcs

extension MainPageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return masterarray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collection.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell()
        }
        DispatchQueue.main.async {
          //  cell.configureCell(text: self.masterarray[indexPath.row])
          //  cell.nameLabel.text = self.masterarray[indexPath.row].capitalized
        }
        
        
        return cell
    }
}


extension MainPageViewController: UICollectionViewDelegateFlowLayout {
    
    func layoutFunc() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 5
        collection.setCollectionViewLayout(layout, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let gridLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let widthPerItem = collectionView.frame.width / 4 - gridLayout.minimumInteritemSpacing
        return CGSize(width:widthPerItem, height:100)
    }
}



