//
//  Extension + Date.swift
//  MyTravel
//
//  Created by Владислав Соколов on 22.06.2024.
//

import Foundation

extension Date {
    func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: self)
    }
}
