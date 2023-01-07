//
//  CollectionViewCell.swift
//  MovieApp
//
//  Created by Emincan on 9.12.2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    static let identifier = "cell"

     let imageView: UIImageView = {
        let imageView = UIImageView()
         imageView.image = UIImage(named: "godfather.jpg")
         imageView.sizeToFit()
        return imageView
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .gray
        contentView.addSubview(imageView)
        
//        NSLayoutConstraint.activate([
//            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
//        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        imageView.frame = contentView.bounds
        // others here with frame or try found with autolayout
    }

}
