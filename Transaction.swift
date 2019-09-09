//
//  Transaction.swift
//  TravelWithFriends
//
//  Created by Yehoon on 4/14/19.
//  Copyright © 2019 Yehoon Joo. All rights reserved.
//

import Foundation

class Transaction: Codable {
    var traveler: String
    var date: String
    var amount: Double
    var item: String
    
    init(traveler: String, date: String, amount: Double, item: String) {
        self.traveler = traveler
        self.date = date
        self.amount = amount
        self.item = item
    }
}
