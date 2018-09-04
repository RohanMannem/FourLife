//
//  FoodItem.swift
//  Food Tracker
//
//  Created by Philip Cheng on 3/14/18.
//  Copyright © 2018 DeAnza. All rights reserved.
//

import UIKit

class FoodItem: NSObject {
    
    // Basic Tracking Info
    var iName : String = ""
    var iServingSize : String = ""
    var iImage = UIImage(named: "")
    
    // Macros (Calories)
    var iCals : Int
    var iProtes : Int
    var iCarbs : Int
    var iFats : Int
    
    // Date Info (Needed for History)
    var iDate : Date
    
    
    // Init - Full Data
    init(iName: String, iImage: UIImage, iServingSize: String, iCals: Int, iProtes: Int, iCarbs: Int, iFats: Int, iDate: Date) {
        
        self.iName = iName
        self.iImage = iImage
        self.iServingSize = iServingSize
        self.iCals = iCals
        self.iProtes = iProtes
        self.iCarbs = iCarbs
        self.iFats = iFats
        self.iDate = iDate
    }
    
}
