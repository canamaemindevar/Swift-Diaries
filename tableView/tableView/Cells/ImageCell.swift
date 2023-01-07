//
//  ImageCell.swift
//  tableView
//
//  Created by Emincan on 30.07.2022.
//

import UIKit

class ImageCell: UITableViewCell {

    @IBOutlet weak var planetImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureImage(imageString:String){
        planetImage.image = UIImage(named: imageString ?? "")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
