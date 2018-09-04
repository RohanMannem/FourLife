//
//  DateSummary.swift
//  FourLife
//
//  Created by Philip Cheng on 3/19/18.
//  Copyright © 2018 DeAnza. All rights reserved.
//

import UIKit

class DateSummary: NSObject {
    
    // Date
    var iDate : Date
    
    // Macros
    var iCals : Int
    var iProtes : Int
    var iCarbs : Int
    var iFats : Int
    
    // Init - Full Data
    init(iDate: Date, iCals: Int, iProtes: Int, iCarbs: Int, iFats: Int ) {
        self.iDate = iDate
        self.iCals = iCals
        self.iProtes = iProtes
        self.iCarbs = iCarbs
        self.iFats = iFats
    }
    
}
