//
//  ViewController.swift
//  TravelWithFriends
//
//  Created by Yehoon on 4/14/19.
//  Copyright © 2019 Yehoon Joo. All rights reserved.
//

import UIKit
import Charts

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pieChartView: PieChartView!
    
    var defaultsData = UserDefaults.standard
    var transactions = [Transaction]()
    var travelers = ["Dave",
                     "In",
                     "Michael",
                     "Luke"]
    var totals = [0.00,
                  0.00,
                  0.00,
                  0.00]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
        loadDefaultsData()
        
        tableView.delegate = self
        tableView.dataSource = self
        // Erase empty rows
        tableView.tableFooterView = UIView(frame: .zero)
        // Prevent scrolling
        tableView.alwaysBounceVertical = false
        
        initPieChart()
    }
    
    func initPieChart() {
        pieChartView.chartDescription?.text = ""
        
        updatePieChartData()
    }
    
    func updatePieChartData() {
        var colors = [UIColor]()
        var dataEntries = [PieChartDataEntry]()
        for i in 0..<travelers.count {
            if(totals[i] > 0.00) {
                colors.append(UIColor(named: String(format: "Traveler %d", i + 1))!)
                
                let dataEntry = PieChartDataEntry(value: totals[i])
                dataEntry.label = travelers[i]
                dataEntry.value = (totals[i] / totals.reduce(0, +)) * 100
                dataEntries.append(dataEntry)
            }
        }
        
        let chartDataSet = PieChartDataSet(values: dataEntries, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        chartDataSet.colors = colors
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 1
        formatter.multiplier = 1.0
        chartData.setValueFormatter(DefaultValueFormatter(formatter: formatter))
        
        pieChartView.data = chartData
    }
    
    //MARK:- Data Storage
    func saveDefaultsData() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(transactions) {
            defaultsData.set(encoded, forKey: "transactions")
            defaultsData.set(encoded, forKey: "totals")
        }
        //defaultsData.set(travelers, forKey: "transactions")
    }
    
    func loadDefaultsData() {
        if let savedArray = defaultsData.object(forKey: "transactions") as? Data {
            let decoder = JSONDecoder()
            if let loadedArray = try? decoder.decode([Transaction].self, from: savedArray) {
                transactions = loadedArray
                for transaction in transactions {
                    let traveler = transaction.traveler
                    if let index = travelers.firstIndex(of: traveler) {
                        totals[index] += transaction.amount
                    }
                }
            }
        }
    }
    
    //MARK:- Segues
    // Add new transaction
    @objc func segueAddItem() {
        performSegue(withIdentifier: "AddTransaction", sender: nil)
    }
    
    // Show all transactions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowAllTransactions" {
            let destination = segue.destination as! AllTransactionsViewController
            destination.transactions = transactions
        } else {
            if let selectedPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedPath, animated: false)
            }
        }
    }
    
    @IBAction func unwindFromDetailTransactionVC(segue: UIStoryboardSegue) {
        let sourceViewController = segue.source as! DetailTransactionViewController
        for i in 0...travelers.count-1 {
            if travelers[i] == sourceViewController.traveler {
                totals[i] += sourceViewController.amount
                let newTransaction = Transaction(traveler: sourceViewController.traveler,
                                                 date: sourceViewController.date,
                                                 amount: sourceViewController.amount,
                                                 item: sourceViewController.item)
                transactions.append(newTransaction)
            }
        }
        tableView.reloadData()
        updatePieChartData()
        saveDefaultsData()
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

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travelers.count
    }
    
    // Adjuting row height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TravelersCell", for: indexPath) as! DoubleTableViewCell
        cell.travelerLabel.text =  travelers[indexPath.row]
        cell.travelerLabel.font = UIFont.boldSystemFont(ofSize: 30.0)
        cell.amountLabel.text = String(format: "$%.02f", totals[indexPath.row])
        cell.amountLabel.font = UIFont .systemFont(ofSize: 30.0)
        
        return cell
    }
    
}
