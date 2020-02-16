//
//  myTableViewCell.swift
//  rush01
//
//  Created by Maksym SALIUTA on 2/16/20.
//  Copyright © 2020 Maksym SALIUTA. All rights reserved.
//

import UIKit

class myTableViewCell: UITableViewCell {
    
    @IBOutlet weak var myLabelTitle: UILabel!
    @IBOutlet weak var myLabelSubTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
