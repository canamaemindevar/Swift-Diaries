//
//  ButtonCell.swift
//  tableView
//
//  Created by Emincan on 30.07.2022.
//

import UIKit

protocol buttonCellDelegate {
    func buttonPressed()
}

class ButtonCell: UITableViewCell {

    var delegate: buttonCellDelegate?
    
    @IBAction func buttonPressed(sender: UIButton){
        if(self.delegate != nil){
            self.delegate?.buttonPressed()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initializationcode
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
