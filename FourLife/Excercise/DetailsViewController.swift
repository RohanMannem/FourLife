//
//  DetailsViewController.swift
//  FourLife
//
//  Created by Rohan Mannem on 3/19/18.
//  Copyright © 2018 DeAnza. All rights reserved.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController {

    @IBOutlet var exerciseTitle: UILabel!
    @IBOutlet var exerciseImage: UIImageView!
    @IBOutlet var exerciseHow: UITextView!
    
    var ExerciseDetail : ExerciseMO!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        if (ExerciseDetail != nil) {
            self.exerciseTitle.text = self.ExerciseDetail.iName
            self.exerciseImage.image = UIImage(data: self.ExerciseDetail.iImage as Data!)
            self.exerciseHow.text = self.ExerciseDetail.iDesc
        }
        
        navigationItem.title = self.exerciseTitle.text! + " in Detail"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
