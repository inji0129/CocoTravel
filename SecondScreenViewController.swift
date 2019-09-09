//
//  SecondScreenViewController.swift
//  TravelWithFriends
//
//  Created by Yehoon on 4/14/19.
//  Copyright © 2019 Yehoon Joo. All rights reserved.
//

import UIKit

class SecondScreenViewController: UIViewController {

    @IBAction func notebutton(_ sender: Any) {
        
    }
    @IBOutlet weak var TravelLogs: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var firstDate: UILabel!
    @IBOutlet weak var lastDate: UILabel!
    
    var finalname = ""
    var finalname2 = ""
    var mydates : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        firstDate.text = finalname //startDate
        lastDate.text = finalname2 //endDate
        
        //var mydates : [String] = []
        
        var dateFrom =  Date() // First date
        var dateTo = Date()   // Last date
        
        // Formatter for printing the date, adjust it according to your needs:
        let fmt = DateFormatter()
        fmt.dateFormat = "MM-dd-yyyy"
        dateFrom = fmt.date(from: finalname)!
        dateTo = fmt.date(from: finalname2)!
        
        
        while dateFrom <= dateTo {
            mydates.append(fmt.string(from: dateFrom))
            dateFrom = Calendar.current.date(byAdding: .day, value: 1, to: dateFrom)!
        }
    }
    
}

extension SecondScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mydates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = mydates[indexPath.row]
        return cell
    }
    
    
}


