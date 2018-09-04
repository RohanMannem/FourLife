//
//  AddFoodItemViewController.swift
//  FourLife
//
//  Created by Philip Cheng on 3/18/18.
//  Copyright © 2018 DeAnza. All rights reserved.
//

import UIKit
import CoreData


class AddFoodItemViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // Food Picker View and Label - Outlets    
    @IBOutlet var foodPickerView: UIPickerView!
    @IBOutlet var selectedFoodLabel: UILabel!
    
    // Food Options to Add
    var foodDataSource : [FoodItem] = []
    var selectedFoodItem : FoodItem = FoodItem(iName: "Empty", iImage: #imageLiteral(resourceName: "spoonfork"), iServingSize: "---", iCals: 0, iProtes: 0, iCarbs: 0, iFats: 0, iDate: Date())
    
    // New Food Item to Add
    var newFoodItem : FoodItemMO!
    
    /****************************************
     * Picker View Functionality
     ****************************************/
    
    /* pickerView.numberOfComponents */
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    /* pickerView.numberOfRowsInComponent */
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return foodDataSource.count
    }
    
    /* pickerView.titleForRow */
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return foodDataSource[row].iName
    }
    
    /* pickerView.didSelectRow */
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedFoodLabel.text = foodDataSource[row].iName
        selectedFoodItem = foodDataSource[row]
    }
    
    
    /****************************************
     * Button Click Aciton Functionality
     ****************************************/
    
    /* addButtonClicked - Adds Selected Food Item to Core Data */
    @IBAction func addButtonClicked(_ sender: Any) {
        
        if (selectedFoodItem.iName != "Empty") {
            
            // Add New Food Item
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                newFoodItem = FoodItemMO(context: appDelegate.persistentContainer.viewContext)
                newFoodItem.iName = selectedFoodItem.iName
                newFoodItem.iServingSize = selectedFoodItem.iServingSize
                newFoodItem.iPicture = NSData(data: UIImagePNGRepresentation((selectedFoodItem.iImage!))!) as Data
                newFoodItem.iCals = Int16(selectedFoodItem.iCals)
                newFoodItem.iCarbs = Int16(selectedFoodItem.iCarbs)
                newFoodItem.iProteins = Int16(selectedFoodItem.iProtes)
                newFoodItem.iFats = Int16(selectedFoodItem.iFats)
                newFoodItem.iDate = Date()
                appDelegate.saveContext()
            }
            
            // Dismiss View Controller
            self.dismiss(animated: true, completion: nil)
            
        } else {
            
            // Send Alert to the User if No Item was Added
            let foodSelectionAlert = UIAlertController(title: "Note", message: "No Item Selected", preferredStyle: UIAlertControllerStyle.alert)
            foodSelectionAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
            self.present(foodSelectionAlert, animated: true, completion: nil)
            
        }
    }
    
    /* cancelButtonClicked - Just Dismiss */
    @IBAction func cancelButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    /*****************************
     * View Loading
     ****************************/
    
    /* viewDidLoad */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createOptionsToLoad()
        foodPickerView.delegate = self
        foodPickerView.dataSource = self
    }
    
    /* didReceiveMemoryWarning */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    /********************************************************************************
     * Food Items to Add (Note: this could be a DB, but used an Array for Simplicity
     ********************************************************************************/
    
    /* createOptionsToLoad -- Creates Library of Items to Add */
    func createOptionsToLoad() {
        foodDataSource.append(FoodItem(iName: "Hamburger", iImage: #imageLiteral(resourceName: "hamburger"), iServingSize: "1/4 Lb.", iCals: 700, iProtes: 200, iCarbs: 200, iFats: 300, iDate: Date()))
        foodDataSource.append(FoodItem(iName: "Pizza", iImage: #imageLiteral(resourceName: "pizza"), iServingSize: "Slice", iCals: 500, iProtes: 200, iCarbs: 200, iFats: 100, iDate: Date()))
        foodDataSource.append(FoodItem(iName: "Carrots", iImage: #imageLiteral(resourceName: "carrots"), iServingSize: "1 Cup", iCals: 75, iProtes: 10, iCarbs: 55, iFats: 10, iDate: Date()))
        foodDataSource.append(FoodItem(iName: "Broccoli", iImage: #imageLiteral(resourceName: "broccoli"), iServingSize: "1 Cup", iCals: 50, iProtes: 10, iCarbs: 30, iFats: 10, iDate: Date()))
    }
    
}

