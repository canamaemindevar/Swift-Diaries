//
//  UserTableViewCell.swift
//  tableView
//
//  Created by Emincan on 29.07.2022.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = .darkGray
        userLabel.textColor = .blue
        numberLabel.textColor = .yellow
        
        
    }
    
    func configureCell(user:String, number:String){
        userLabel.text = user
       numberLabel.text = number
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
