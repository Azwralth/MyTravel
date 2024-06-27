//
//  Trip.swift
//  MyTravel
//
//  Created by Владислав Соколов on 18.06.2024.
//

import Foundation
import SwiftData

@Model
final class Trip {
    var name: String
    var startDate: Date
    var endDate: Date
    var expense: [Expense]
    var budget: Double
    var currency: String
    
    init(name: String, startDate: Date, endDate: Date, expense: [Expense], budget: Double, currency: String) {
        self.name = name
        self.startDate = startDate
        self.endDate = endDate
        self.expense = expense
        self.budget = budget
        self.currency = currency
    }
}

@Model
final class Expense {
    let name: String
    let expense: Double
    let date: Date
    
    init(name: String, expense: Double, date: Date) {
        self.name = name
        self.expense = expense
        self.date = date
    }
}



