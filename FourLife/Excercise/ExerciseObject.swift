//
//  ExerciseObject.swift
//  FourLife
//
//  Created by Rohan Mannem on 3/19/18.
//  Copyright © 2018 DeAnza. All rights reserved.
//

import UIKit

class ExerciseObject: NSObject {
    
    var iName = ""
    var iImage = UIImage(named: "")
    var iDesc = ""
    var iCheck = false
    
    // Date Info (Needed for History)
    var iDate : Date
    
    init(iName: String, iImage: UIImage, iDesc: String, iCheck: Bool, iDate: Date)
    {
        self.iName = iName
        self.iImage = iImage
        self.iDesc = iDesc
        self.iCheck = iCheck
        self.iDate = iDate
    }
}
