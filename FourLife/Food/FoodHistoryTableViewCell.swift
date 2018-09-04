//
//  FoodHistoryTableViewCell.swift
//  FourLife
//
//  Created by Philip Cheng on 3/19/18.
//  Copyright © 2018 DeAnza. All rights reserved.
//

import UIKit

class FoodHistoryTableViewCell: UITableViewCell {
    
    // Outlets
    
    @IBOutlet var iDate: UILabel!
    @IBOutlet var iCals: UILabel!
    @IBOutlet var iCarbs: UILabel!
    @IBOutlet var iProtes: UILabel!
    @IBOutlet var iFats: UILabel!
    
    // Functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

