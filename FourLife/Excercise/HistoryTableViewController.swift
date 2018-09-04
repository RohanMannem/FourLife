//
//  HistoryTableViewController.swift
//  FourLife
//
//  Created by Rohan Mannem on 3/19/18.
//  Copyright © 2018 DeAnza. All rights reserved.
//

import UIKit
import CoreData

class HistoryTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    let navbar = UINavigationBar.appearance()
    
    // Excerises and History
    var ExercisesDone : [ExerciseMO] = []
    var exerciseHistory : [Int] = []
    
    // FetchedResults Controller
    var fetchedResultsController : NSFetchedResultsController<ExerciseMO>!
    
    
    /* fetchData -- Load Data from DB into exercise Item List */
    func fetchData() -> Bool {
        
        let fetchRequest : NSFetchRequest<ExerciseMO> = ExerciseMO.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "iName", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let context = appDelegate.persistentContainer.viewContext
            fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName:nil)
            fetchedResultsController.delegate = self
            do {
                try fetchedResultsController.performFetch()
                if let fetchedObjects = fetchedResultsController.fetchedObjects {
                    ExercisesDone = fetchedObjects
                }
            } catch {
                print (error)
            }
        }
        
        return (ExercisesDone.count > 0)
    }
    
    /* fillExerciseHistory */
    func fillExerciseHistory() {
        
        let formatter = DateFormatter()
        
        // Get Start of Today's Date
        formatter.dateFormat = "yyyy/MM/dd 00:00:00"
        let dateString = formatter.string(from: Date())
        var startOfDay = formatter.date(from: dateString)
        
        // Clear Exercse History
        exerciseHistory.removeAll()
        
        // Go Back Two Weeks and Add Empty Date Summaries
        for _ in 0...14 {
            exerciseHistory.append(0)
            startOfDay = (startOfDay! - 60*60*24) + 100
        }
        
        // Sum # from Core Data
        for i in 0..<ExercisesDone.count {
            let exercise = ExercisesDone[i]
            if (exercise.iDate! > startOfDay!) {
                let index = floor(((exercise.iDate?.timeIntervalSince1970)! - (startOfDay?.timeIntervalSince1970)!) / (60*60*24))
                let intIndex = Int(floor(15 - index))
                exerciseHistory[intIndex] = exerciseHistory[intIndex] + 1
            }
        }
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "History"
        navbar.tintColor = UIColor.cyan
    }
    
    /* viewWillAppear -- Refetch and Re-populate Table */
    override func viewWillAppear(_ animated: Bool) {
        viewDidLoad()
        if (fetchData()) {
            fillExerciseHistory()
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
            ExercisesDone = fetchedObjects as! [ExerciseMO]
        }
        tableView.reloadData()
        
    }
    
    /* ControllerDidChangeContent */
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return exerciseHistory.count + 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ToHistory"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! HistoryTableViewCell
        
        if (indexPath.row == 0) {
            
            // Header Row
            cell.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.7, alpha: 0.1)
            cell.date.text = "Date"
            cell.numberOfWorkouts.text = "Number Of Workouts"
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
        } else {
            
            // Regular Row
            cell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            
            // Set Cell Date
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd/YY"
            let dateString = formatter.string(from: Date() - TimeInterval((indexPath.row - 1) * 60*60*24))
            cell.date.text = dateString
            
        
            
            // Set Cell Macros
            cell.numberOfWorkouts.text = String(exerciseHistory[indexPath.row - 1])
            
            
        }
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
