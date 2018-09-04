//
//  HistoryTableViewCell.swift
//  FourLife
//
//  Created by Rohan Mannem on 3/20/18.
//  Copyright © 2018 DeAnza. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    

    @IBOutlet var date: UILabel!
    @IBOutlet var numberOfWorkouts: UILabel!
    
    var ExerciseDone : ExerciseMO!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
