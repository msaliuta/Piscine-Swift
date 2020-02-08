//
//  TableViewCell.swift
//  d04
//
//  Created by Maksym SALIUTA on 2/8/20.
//  Copyright © 2020 Maksym SALIUTA. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var textLbl: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var name: UILabel!
    
    var tweet: Tweet? {
        didSet {
            name.text = tweet!.name;
            textLbl.text = tweet!.text;
            date.text = tweet!.date;
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
