//
//  DatesViewController.swift
//  TravelWithFriends
//
//  Created by Yehoon on 4/14/19.
//  Copyright © 2019 Yehoon Joo. All rights reserved.
//

import UIKit

class DatesViewController: UIViewController {

    var firstDate = ""
    var lastDate = ""
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var endDate: UILabel!
    @IBOutlet weak var pickerStart: UIDatePicker!
    @IBOutlet weak var pickerEnd: UIDatePicker!
    @IBOutlet weak var begin: UILabel!
    @IBOutlet weak var end: UILabel!
    @IBAction func nextViewButtonPressed(_ sender: Any) {
        self.firstDate = begin.text!
        self.lastDate = end.text!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let vc = segue.destination as! SecondScreenViewController
        vc.finalname = self.firstDate
        let vc2 = segue.destination as! SecondScreenViewController
        vc2.finalname2 = self.lastDate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
    }
    
    
    @IBAction func getStartDate(_ sender: Any) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        begin.text = formatter.string(from:pickerStart.date)
        
        
    }
    @IBAction func getEndDate(_ sender: Any) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        end.text = formatter.string(from:pickerEnd.date)
    }
    
    @IBAction func homeButtonPressed(_ sender: UIBarButtonItem) {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode { // modal segue
            dismiss(animated: true, completion: nil)
        } else { // show segue
            navigationController!.popViewController(animated: true)
        }
    }
}

