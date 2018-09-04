//
//  FoodItemDetailViewController.swift
//  FourLife
//
//  Created by Philip Cheng on 3/18/18.
//  Copyright © 2018 DeAnza. All rights reserved.
//

import UIKit

class FoodItemDetailViewController: UIViewController {
    
    // Outlets
    
    @IBOutlet var iFoodImage: UIImageView!
    @IBOutlet var iFoodName: UILabel!
    @IBOutlet var iFoodDetails: UITextView!
    
    // Class Variables
    
    var foodItemData : FoodItemMO!
    
    // Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /* viewWillAppear */
    override func viewWillAppear(_ animated: Bool) {
        if (foodItemData != nil) {
            
            // Image and Name
            iFoodImage.image = UIImage(data: self.foodItemData.iPicture as Data!)
            iFoodName.text = foodItemData.iName?.uppercased()
            
            // Details
            var foodText = "Serving Size:  " + foodItemData.iServingSize! + "\n"
            foodText = foodText + "Calories:      " + String(foodItemData.iCals) + "\n"
            foodText = foodText + "Carbohydrates: " + String(foodItemData.iCarbs) + "\n"
            foodText = foodText + "Proteins:      " + String(foodItemData.iProteins) + "\n"
            foodText = foodText + "Fats:          " + String(foodItemData.iFats) + "\n"
            
            // Date -- QQQ: FIX THIS
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let dateString = formatter.string(from: foodItemData.iDate!)
            foodText = foodText + "Date:          " + dateString
            
            iFoodDetails.text = foodText
            
        }
    }
    
    /* didReceiveMemoryWarning */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

