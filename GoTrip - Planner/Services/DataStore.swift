//
//  DataStore.swift
//  GoTrip - Planner
//
//  Created by Владислав Соколов on 27.06.2024.
//

import Foundation

final class DataStore {
    static let shared = DataStore()
    
    private let currencies = [
        "USD", "EUR", "RUB", "GBP", "AUD", "CAD", "CHF", "CNY", "SEK", "NZD",
        "KRW", "SGD", "NOK", "MXN", "INR", "JPY", "HKD", "ZAR", "BRL", "TRY",
        "DKK", "PLN", "THB", "TWD", "IDR", "HUF", "CZK", "ILS", "CLP", "PHP",
        "AED", "ARS", "COP", "EGP", "MYR", "NPR", "PKR", "SAR", "VND", "IQD",
        "UAH", "UZS", "BDT", "BHD", "BND", "CRC", "DOP", "JOD", "KZT", "LKR"
    ]

    func getAllCurrncies() -> [String] {
        return currencies
    }
    
    private init() {}
}
