//
//  AddExerciseViewController.swift
//  FourLife
//
//  Created by Rohan Mannem on 3/19/18.
//  Copyright © 2018 DeAnza. All rights reserved.
//

import UIKit
import CoreData

class AddExerciseViewController: UIViewController {

    @IBOutlet var addName: UITextField!
    @IBOutlet var addDesc: UITextField!
    @IBOutlet var addImage: UITextField!
    
    var newExercise : ExerciseMO!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Save(_ sender: Any) {
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            newExercise = ExerciseMO(context: appDelegate.persistentContainer.viewContext)
            
            newExercise.iName = addName.text!
            newExercise.iDesc = addDesc.text!
            newExercise.iImage = NSData(data: UIImagePNGRepresentation(#imageLiteral(resourceName: "cardio"))!) as Data
            
            if (UIImage(named: addImage.text!) != nil) {
                newExercise.iImage = NSData(data: UIImagePNGRepresentation(UIImage(named: addImage.text!)!)!) as Data
            }
            
            
            
            
            newExercise.iDate = Date()
            
            appDelegate.saveContext()
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func Cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
