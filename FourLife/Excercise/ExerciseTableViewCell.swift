//
//  ExerciseTableViewCell.swift
//  FourLife
//
//  Created by Rohan Mannem on 3/19/18.
//  Copyright © 2018 DeAnza. All rights reserved.
//

import UIKit

class ExerciseTableViewCell: UITableViewCell {

    @IBOutlet var exerciseImage: UIImageView!
    @IBOutlet var exerciseName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
