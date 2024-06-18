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
    let name: String
    let date: Date
    let expense: [Expense]
    let income: [Income]
    let budget: Double
    
    init(name: String, date: Date, expense: [Expense], income: [Income], budget: Double) {
        self.name = name
        self.date = date
        self.expense = expense
        self.income = income
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

@Model
final class Income {
    let name: String
    let income: Double
    let date: Date
    
    init(name: String, income: Double, date: Date) {
        self.name = name
        self.income = income
        self.date = date
    }
}



