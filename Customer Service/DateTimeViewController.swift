//
//  DateTimeViewController.swift
//  Customer Service
//
//  Created by masterUNG on 5/9/2560 BE.
//  Copyright © 2560 EWTC. All rights reserved.
//

import UIKit

class DateTimeViewController: UIViewController {
    
    @IBOutlet weak var dateTimeLabel: UILabel!
    
    @IBOutlet weak var datePickerOutlet: UIDatePicker!
    
    @IBOutlet weak var confirmTimeOutlet: UIButton!

    @IBOutlet weak var okOutlet: UIButton!
    
    @IBOutlet weak var editOutlet: UIButton!
    
    
    
    @IBAction func okAction(_ sender: Any) {
        
        let strValue = dateTimeLabel.text
        print("strValue ==> " + strValue!)
        performSegue(withIdentifier: "goHome", sender: strValue)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goHome" {
            if let desination = segue.destination as? ViewController {
                desination.stringPassed = (sender as? String)!
            }
        }
    }
    
    
    @IBAction func datePickerAction(_ sender: Any) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        var strDate = dateFormatter.string(from: datePickerOutlet.date)
        self.dateTimeLabel.text = strDate
        
    }
    
    
    @IBAction func editAction(_ sender: Any) {
        
        //Show And Visible View
        dateTimeLabel.alpha = 0
        okOutlet.alpha = 0
        editOutlet.alpha = 0
        datePickerOutlet.alpha = 1
        confirmTimeOutlet.alpha = 1
        
        
    }
    
    @IBAction func confirmTimeAction(_ sender: Any) {
        
        //Show And Visible View
        dateTimeLabel.alpha = 1
        okOutlet.alpha = 1
        editOutlet.alpha = 1
        datePickerOutlet.alpha = 0
        confirmTimeOutlet.alpha = 0
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print("DateTime Work")
        
    }   // viewDidLoad

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}   // Main Class
