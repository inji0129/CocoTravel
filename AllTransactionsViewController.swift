//
//  AllTransactionsViewController.swift
//  TravelWithFriends
//
//  Created by Yehoon on 4/14/19.
//  Copyright © 2019 Yehoon Joo. All rights reserved.
//

import UIKit

class AllTransactionsViewController: UIViewController {
    
    @IBOutlet weak var transactionsTableView: UITableView!
    
    var transactions = [Transaction]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
        
        transactionsTableView.delegate = self
        transactionsTableView.dataSource = self
        
        // Erase empty rows
        transactionsTableView.tableFooterView = UIView(frame: .zero)
        // Prevent scrolling
        transactionsTableView.alwaysBounceVertical = false
    }
    
}

extension AllTransactionsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell", for: indexPath)
        let cellText = transactions[indexPath.row].date + ": " + transactions[indexPath.row].traveler + " paid $" + String(transactions[indexPath.row].amount) + " for " + transactions[indexPath.row].item + "."
        cell.textLabel?.text = cellText
        cell.textLabel?.font = UIFont .systemFont(ofSize: 18.0)
        return cell
    }
    
}
