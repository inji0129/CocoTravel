//
//  DetailTransactionViewController.swift
//  TravelWithFriends
//
//  Created by Yehoon on 4/14/19.
//  Copyright © 2019 Yehoon Joo. All rights reserved.
//

import UIKit

class DetailTransactionViewController: UIViewController {
    
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var itemTextField: UITextField!
    @IBOutlet weak var travelerTextField: UITextField!
    
    let datePicker = UIDatePicker()
    let dateFormatter = DateFormatter()
    let travelerPicker = UIPickerView()
    var travelerPickerRow = 0
    
    var amount = 0.0
    var item = ""
    var traveler = ""
    var date = ""
    var travelers = ["Dave",
                     "In",
                     "Michael",
                     "Luke"]
    
    var defaultsData = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
        
        traveler = travelers[0]
        
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        setupDateTextField()
        
        travelerPicker.dataSource = self
        travelerPicker.delegate = self
        setupTravelerTextField()
        
        amountTextField.delegate = self
        amountTextField.keyboardType = .decimalPad
        
        amountTextField.delegate = self
        setupAmountTextField()
        
    }
    
    func setupTravelerTextField() {
        let travelerToolbar = UIToolbar()
        travelerToolbar.sizeToFit()
        let travelerDoneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(travelerDonePressed))
        travelerTextField.inputView = travelerPicker
        travelerToolbar.setItems([travelerDoneButton], animated: false)
        travelerTextField.inputAccessoryView = travelerToolbar
    }
    
    @objc func travelerDonePressed() {
        travelerTextField.text = travelers[travelerPickerRow]
        self.view.endEditing(true)
    }
    
    func setupDateTextField() {
        // toolbar
        let dateToolbar = UIToolbar()
        dateToolbar.sizeToFit()
        let dateDoneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(dateDonePressed))
        datePicker.datePickerMode = .date
        dateTextField.inputView = datePicker
        dateToolbar.setItems([dateDoneButton], animated: false)
        dateTextField.inputAccessoryView = dateToolbar
    }
    
    @objc func dateDonePressed() {
        dateTextField.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @IBAction func dateTextFieldChanged(_ sender: UITextField) {
        dateTextField.text = dateFormatter.string(from: datePicker.date)
    }
    
    func setupAmountTextField() {
        let amountToolbar = UIToolbar()
        amountToolbar.sizeToFit()
        let amountDoneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(amountDonePressed))
        amountToolbar.setItems([amountDoneButton], animated: false)
        amountTextField.inputAccessoryView = amountToolbar
    }
    
    @objc func amountDonePressed() {
        self.view.endEditing(true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindFromSave" {
            traveler = travelerTextField.text!
            date = dateTextField.text!
            amount = Double(amountTextField.text ?? "0.0")!
            item = itemTextField.text!
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode { // modal segue
            dismiss(animated: true, completion: nil)
        } else { // show segue
            navigationController!.popViewController(animated: true)
        }
    }
}

extension DetailTransactionViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return travelers.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return travelers[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        travelerPickerRow = row
        travelerTextField.text = travelers[row]
    }
    
    // Limit to 2 decimal places
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let oldText = textField.text, let r = Range(range, in: oldText) else {
            return true
        }
        
        let newText = oldText.replacingCharacters(in: r, with: string)
        let isNumeric = newText.isEmpty || (Double(newText) != nil)
        let numberOfDots = newText.components(separatedBy: ".").count - 1
        
        let numberOfDecimalDigits: Int
        if let dotIndex = newText.firstIndex(of: ".") {
            numberOfDecimalDigits = newText.distance(from: dotIndex, to: newText.endIndex) - 1
        } else {
            numberOfDecimalDigits = 0
        }
        
        return isNumeric && numberOfDots <= 1 && numberOfDecimalDigits <= 2
    }
}
