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
    var expense: [Expense]?
    var budget: Double
    
    init(name: String, startDate: Date, endDate: Date, expense: [Expense]? = nil, budget: Double) {
        self.name = name
        self.startDate = startDate
        self.endDate = endDate
        self.expense = expense
        self.budget = budget
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



