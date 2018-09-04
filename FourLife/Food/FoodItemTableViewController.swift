//
//  FoodItemTableViewController.swift
//  FourLife
//
//  Created by Philip Cheng on 3/18/18.
//  Copyright © 2018 DeAnza. All rights reserved.
//

import UIKit
import CoreData

class FoodItemTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    /****************************************
     * Database Seed Functionality (For Demo)
     ****************************************/
    
    // foodSeedList - Seed Data to Populate this Table View Controller (For Demo)
    var foodSeedList = [
        FoodItem(iName:"Broccoli", iImage: #imageLiteral(resourceName: "broccoli"), iServingSize : "1 Cup",
                 iCals : 50, iProtes : 5, iCarbs : 40, iFats : 5,
                 iDate : Date() - (3 * (60*60*24))),
        FoodItem(iName:"Carrots", iImage: #imageLiteral(resourceName: "carrots"), iServingSize : "1 Cup",
                 iCals : 50, iProtes : 5, iCarbs : 40, iFats : 5,
                 iDate : Date() - (3 * (60*60*24))),
        FoodItem(iName:"Hamburger", iImage: #imageLiteral(resourceName: "hamburger"), iServingSize : "1/4 Lb.",
                 iCals : 800, iProtes : 200, iCarbs : 200, iFats : 400,
                 iDate : Date() - (2 * (60*60*24))),
        FoodItem(iName:"Pizza", iImage: #imageLiteral(resourceName: "pizza"), iServingSize : "Slice",
                 iCals : 600, iProtes : 100, iCarbs : 300, iFats : 200,
                 iDate : Date() - (1 * (60*60*24)))
    ]
    
    // checkForSeeded - Check if the Database (DB) is already seeded
    func checkForSeeded() -> Bool {
        let fetchRequest : NSFetchRequest<FoodItemMO> = FoodItemMO.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "iName", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let context = appDelegate.persistentContainer.viewContext
            fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName:nil)
            fetchedResultsController.delegate = self
            do {
                try fetchedResultsController.performFetch()
                if let fetchedObjects = fetchedResultsController.fetchedObjects {
                    return (fetchedObjects.count > 0)
                }
            } catch {
                print (error)
            }
        }
        return false
    }
    
    // seedDatabase - Seed the DB with data from the "Seed Data" Array (For Demo)
    func seedDatabase() {
        for i in 0...(foodSeedList.count-1) {
            var newFood : FoodItemMO!
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                newFood = FoodItemMO(context: appDelegate.persistentContainer.viewContext)
                newFood.iPicture = UIImagePNGRepresentation(foodSeedList[i].iImage!)
                newFood.iName = foodSeedList[i].iName
                newFood.iServingSize = foodSeedList[i].iServingSize
                newFood.iCals = Int16(foodSeedList[i].iCals)
                newFood.iCarbs = Int16(foodSeedList[i].iCarbs)
                newFood.iProteins = Int16(foodSeedList[i].iProtes)
                newFood.iFats = Int16(foodSeedList[i].iFats)
                newFood.iDate = foodSeedList[i].iDate
            }
        }
    }
    
    
    /**********************************************************
     * Food List and Fetched Results Controller (For Core Data)
     **********************************************************/
    
    // Food List - Food Items Pulled From Core Data
    var foodItemList : [FoodItemMO] = []
    
    // FetchedResults Controller - For Core Data
    var fetchedResultsController : NSFetchedResultsController<FoodItemMO>!
    
    
    /**********************************************************
     * View Loading (and Reloading with Core Data)
     **********************************************************/
    
    /* ViewDidLoad */
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Seed the DB
        if (!checkForSeeded()) {
            self.seedDatabase()
        }
        
        // Load Data from DB into Food Item List
        let fetchRequest : NSFetchRequest<FoodItemMO> = FoodItemMO.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "iName", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let context = appDelegate.persistentContainer.viewContext
            fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName:nil)
            fetchedResultsController.delegate = self
            do {
                try fetchedResultsController.performFetch()
                if let fetchedObjects = fetchedResultsController.fetchedObjects {
                    foodItemList = fetchedObjects
                }
            } catch {
                print (error)
            }
        }
    }
    
    /* ControllerWillChangeContent */
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    /* Controller DidChange */
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath {
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
        default:
            tableView.reloadData()
        }
        
        if let fetchedObjects = controller.fetchedObjects {
            foodItemList = fetchedObjects as! [FoodItemMO]
        }
        
    }
    
    /* ControllerDidChangeContent */
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    /* DidReceiveMemoryWarning */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Table view data source
    
    /* NumberOfSections */
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /* NumberOfRowsInSection */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodItemList.count + 2
    }
    
    /* CellForRowAt */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Dequeue Reuseable Rows
        let cellIdentifier = "FoodItemCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FoodItemTableViewCell
        
        if (indexPath.row == 0) {
            
            // Header Row
            cell.backgroundColor = UIColor(red: 0.7, green: 0.9, blue: 0.7, alpha: 1.0)
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
            // Header Row Text
            cell.iFoodImage.image = #imageLiteral(resourceName: "spoonfork")
            cell.iFoodName.text = "Food"
            cell.iFoodServingSize.text = "Serving Size"
            cell.iFoodCalories.text = "Cals"
            cell.iFoodProteins.text = "Protein"
            cell.iFoodCarbohydrates.text = "Carbs"
            cell.iFoodFats.text = "Fats"
            
        } else {
            
            if (indexPath.row == foodItemList.count + 1) {
                
                // Footer Row
                cell.backgroundColor = UIColor(red: 0.7, green: 0.9, blue: 0.7, alpha: 1.0)
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                
                // Footer Row Data
                let foodItem = TotalCalories()
                cell.iFoodImage.image = #imageLiteral(resourceName: "sum")
                cell.iFoodName.text = "Total"
                cell.iFoodServingSize.text = "-----"
                cell.iFoodCalories.text = String(foodItem.iCals)
                cell.iFoodProteins.text = String(foodItem.iProtes)
                cell.iFoodCarbohydrates.text = String(foodItem.iCarbs)
                cell.iFoodFats.text = String(foodItem.iFats)
                
            } else {
                
                // Regular Food Item Row Data
                let foodItem = foodItemList[indexPath.row - 1]
                cell.iFoodImage.image = UIImage(data: foodItem.iPicture as Data!)
                cell.iFoodName.text = foodItem.iName
                cell.iFoodServingSize.text = foodItem.iServingSize
                cell.iFoodCalories.text = String(foodItem.iCals)
                cell.iFoodProteins.text = String(foodItem.iProteins)
                cell.iFoodCarbohydrates.text = String(foodItem.iCarbs)
                cell.iFoodFats.text = String(foodItem.iFats)
            }
        }
        
        // Return the Cell
        return cell
        
    }
    
    
    /* TotalCalories - Computes Total Cals, Carbs, Proteins, and Fats */
    func TotalCalories() -> FoodItem {
        
        // Macro Sums
        var cals = 0
        var protein = 0
        var carbohydrates = 0
        var fats = 0
        
        // Sum the Macros
        for i in 0...(foodItemList.count-1) {
            cals = cals + Int(foodItemList[i].iCals)
            protein = protein + Int(foodItemList[i].iProteins)
            carbohydrates = carbohydrates + Int(foodItemList[i].iCarbs)
            fats = fats + Int(foodItemList[i].iFats)
        }
        
        // Return a FoodItem with the Total Numbers
        return FoodItem(iName:"TOTAL", iImage: #imageLiteral(resourceName: "sum"), iServingSize : "---", iCals : cals, iProtes : protein, iCarbs : carbohydrates, iFats : fats, iDate : Date())
    }
    
    // Override to support editing the table view
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                let context = appDelegate.persistentContainer.viewContext
                let itemToDelete = self.fetchedResultsController.fetchedObjects![indexPath.row - 1] //    .object(at: indexPath)
                context.delete(itemToDelete)
                appDelegate.saveContext()
            }
        }
    }
    
    
    /****************************************
     * Segue Functionality
     ****************************************/
    
    // MARK: - Navigation
    
    // shouldPerformSegue - Prevent Segue on Header and Footer Rows
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (identifier == "ShowFoodDetail") {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                return (indexPath.row > 0 && indexPath.row < foodItemList.count + 1)
            }
            return false
        }
        return true // For ALL other Segue Types
    }
    
    // Prepare for Segue - Pass Food Item Details
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ShowFoodDetail") {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let detailVC = segue.destination as! FoodItemDetailViewController
                detailVC.foodItemData =  foodItemList[indexPath.row - 1]
            }
        }
    }
    
}

