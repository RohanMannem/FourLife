//
//  ExercisesTableViewController.swift
//  FourLife
//
//  Created by Rohan Mannem on 3/19/18.
//  Copyright © 2018 DeAnza. All rights reserved.
//

import UIKit
import CoreData

class ExercisesTableViewController: UITableViewController, UISearchResultsUpdating, NSFetchedResultsControllerDelegate  {

    @IBOutlet var Exercises: UITableView!
    
    var searchController : UISearchController!
    var searchResults: [ExerciseMO] = []
    
    var fetchResultsController : NSFetchedResultsController<ExerciseMO>!
    var ListOfExercises : [ExerciseMO] = []
    
    let navbar = UINavigationBar.appearance()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        navigationItem.title = "Today's Workout"
        navbar.tintColor = UIColor.cyan
        
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.searchBar.sizeToFit()
        self.searchController.hidesNavigationBarDuringPresentation = false;
        self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
        self.tableView.tableHeaderView = self.searchController.searchBar
        
        let fetchRequest : NSFetchRequest<ExerciseMO> = ExerciseMO.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "iName", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let context = appDelegate.persistentContainer.viewContext
            fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultsController.delegate = self
            
            do {
                try fetchResultsController.performFetch()
                if let fetchedObjects = fetchResultsController.fetchedObjects {
                    ListOfExercises = fetchedObjects
                }
            } catch {
                print(error)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if searchController.isActive {
            return searchResults.count
        }
        else {
            return ListOfExercises.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Exercises"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ExerciseTableViewCell
        
        // Configure the cell...
        /*cell.exerciseName.text = ListOfExercises[indexPath.row].iName
         cell.exerciseImage.image = ListOfExercises[indexPath.row].iImage*/
        
        var cellItem : ExerciseMO
        if searchController.isActive {
            cellItem = searchResults[indexPath.row]
        }
        else {
            cellItem = ListOfExercises[indexPath.row]
        }
        
        //cell.exerciseImage.image = UIImage(data: cellItem.iImage as Data!)
        cell.exerciseName?.text = cellItem.iName
        cell.exerciseImage?.image = UIImage(data: cellItem.iImage as Data!)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /*if segue.identifier == "AddExercise" {
         let addVC = segue.destination as! AddExerciseViewController
         addVC.newExercise = addData
         }*/
        if segue.identifier == "ToDetails" {
            if let indexPath = self.Exercises.indexPathForSelectedRow {
                let destVC = segue.destination as! DetailsViewController
                
                destVC.ExerciseDetail = searchController.isActive ? searchResults[indexPath.row] : ListOfExercises[indexPath.row]
            }
        }
    }
    
    func addData(newItem : ExerciseMO){
        ListOfExercises.append(newItem)
    }
    
    func filterContentForSearchText(searchText: String)
    {
        searchResults = ListOfExercises.filter({ (ExerciseItem: ExerciseMO) -> Bool in
            let nameMatch = ExerciseItem.iName?.range(of:searchText, options: String.CompareOptions.caseInsensitive)
            return nameMatch != nil
        })
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let textToSearch = searchController.searchBar.text
        {
            filterContentForSearchText(searchText: textToSearch)
            tableView.reloadData()
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case.insert:
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .fade)
            }
        case.delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        case.update:
            if let indexPath = indexPath {
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
        default:
            tableView.reloadData()
        }
        
        if let fetchedObjects = controller.fetchedObjects {
            ListOfExercises = fetchedObjects as! [ExerciseMO]
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                let context = appDelegate.persistentContainer.viewContext
                let itemToDelete = self.fetchResultsController.object(at: indexPath)
                context.delete(itemToDelete)
                appDelegate.saveContext()
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    
    
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
