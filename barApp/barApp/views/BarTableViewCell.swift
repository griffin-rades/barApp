//
//  BarTableViewCell.swift
//  barApp
//
//  Created by Griffin Rades on 11/28/19.
//  Copyright © 2019 GriffinRades. All rights reserved.
//

import UIKit

class BarTableViewCell: UITableViewCell {

    @IBOutlet weak var barNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
