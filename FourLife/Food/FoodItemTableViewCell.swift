//
//  FoodItemTableViewCell.swift
//  FourLife
//
//  Created by Philip Cheng on 3/18/18.
//  Copyright © 2018 DeAnza. All rights reserved.
//

import UIKit

class FoodItemTableViewCell: UITableViewCell {
    
    // Outlets
    
    @IBOutlet var iFoodImage: UIImageView!
    @IBOutlet var iFoodName: UILabel!
    @IBOutlet var iFoodServingSize: UILabel!
    @IBOutlet var iFoodCalories: UILabel!
    @IBOutlet var iFoodCarbohydrates: UILabel!
    @IBOutlet var iFoodProteins: UILabel!
    @IBOutlet var iFoodFats: UILabel!
    
    // Functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

