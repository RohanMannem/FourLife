//
//  FoodHistoryTableViewController.swift
//  FourLife
//
//  Created by Philip Cheng on 3/19/18.
//  Copyright © 2018 DeAnza. All rights reserved.
//

import UIKit
import CoreData

class FoodHistoryTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    /**********************************************************
     * Food Lists and Fetched Results Controller (For Core Data)
     **********************************************************/
    
    // Food List -- All Food Items Pulled From Core Data (DB)
    var foodItemList : [FoodItemMO] = []
    
    // Food History Array -- Stores the Macros (Calories Per Day
    var foodHistory : [DateSummary] = []
    
    // FetchedResults Controller
    var fetchedResultsController : NSFetchedResultsController<FoodItemMO>!
    
    
    /* fetchData -- Load Data from DB into Food Item List */
    func fetchData() -> Bool {
        
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
        
        return (foodItemList.count > 0)
    }
    
    /* fillFoodHistory */
    func fillFoodHistory() {
        
        let formatter = DateFormatter()
        
        // Get Start of Today's Date
        formatter.dateFormat = "yyyy/MM/dd 00:00:00"
        let dateString = formatter.string(from: Date())
        var startOfDay = formatter.date(from: dateString)
        
        // Clear Food History
        foodHistory.removeAll()
        
        // Go Back Two Weeks and Add Empty Date Summaries
        for _ in 0...14 {
            foodHistory.append(DateSummary(iDate: startOfDay!, iCals: 0, iProtes: 0, iCarbs: 0, iFats: 0 ))
            startOfDay = (startOfDay! - 60*60*24) + 100 // <-- Pretty Hacky, might want to update.
        }
        
        // Sum Macros from Core Data
        for i in 0..<foodItemList.count {
            let food = foodItemList[i]
            if (food.iDate! > startOfDay!) {
                let index = floor(((food.iDate?.timeIntervalSince1970)! - (startOfDay?.timeIntervalSince1970)!) / (60*60*24))
                let intIndex = Int(floor(15 - index))
                foodHistory[intIndex].iCals = foodHistory[intIndex].iCals + Int(food.iCals)
                foodHistory[intIndex].iCarbs = foodHistory[intIndex].iCarbs + Int(food.iCarbs)
                foodHistory[intIndex].iProtes = foodHistory[intIndex].iProtes + Int(food.iProteins)
                foodHistory[intIndex].iFats = foodHistory[intIndex].iFats + Int(food.iFats)
            }
        }
        
        tableView.reloadData()
    }
    
    
    /**********************************************************
     * View Loading (and Reloading with Core Data)
     **********************************************************/
    
    /* ViewDidLoad */
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /* viewWillAppear -- Refetch and Re-populate Table */
    override func viewWillAppear(_ animated: Bool) {
        viewDidLoad()
        if (fetchData()) {
            fillFoodHistory()
        }
    }
    
    /* viewDidAppear -- Reload Load to Table */
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
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
        tableView.reloadData()
        
    }
    
    /* ControllerDidChangeContent */
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
        tableView.reloadData()
    }
    
    /* didReceiveMemoryWarning */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    /* numberOfSections */
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /* numberOfRowsInSection */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodHistory.count + 1
    }
    
    /* cellForRowAt */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "FoodHistoryCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FoodHistoryTableViewCell
        
        if (indexPath.row == 0) {
            
            // Header Row
            cell.backgroundColor = UIColor(red: 0.7, green: 0.9, blue: 0.7, alpha: 1.0)
            cell.iDate.text = "Date"
            cell.iCals.text = "Cals"
            cell.iCarbs.text = "Carbs"
            cell.iProtes.text = "Protein"
            cell.iFats.text = "Fats"
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
        } else {
            
            // Regular Row
            cell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            
            // Set Cell Date
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd/YY"
            let dateString = formatter.string(from: foodHistory[indexPath.row - 1].iDate)
            cell.iDate.text = dateString
            
            // Set Cell Macros
            cell.iCals.text = String(foodHistory[indexPath.row - 1].iCals)
            cell.iCarbs.text = String(foodHistory[indexPath.row - 1].iCarbs)
            cell.iProtes.text = String(foodHistory[indexPath.row - 1].iProtes)
            cell.iFats.text = String(foodHistory[indexPath.row - 1].iFats)
            
        }
        
        return cell
    }
    
}

