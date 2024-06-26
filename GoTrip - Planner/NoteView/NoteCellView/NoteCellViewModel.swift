//
//  NoteCellViewModel.swift
//  MyTravel
//
//  Created by Владислав Соколов on 22.06.2024.
//

import Foundation
import SwiftUI

final class NoteCellViewModel: ObservableObject {
    private let note: Note
    
    init(note: Note) {
        self.note = note
    }
    
    var title: String {
        note.annotation.title
    }
    
    var formattedDate: String {
        note.date.formatted()
    }
    
    var name: String {
        note.name
    }
    
    func daysLeft() -> Int {
        let days = Int(note.deadline.timeIntervalSinceNow / 86400)
        return days
    }
    
    func daysWord() -> String {
        let days = daysLeft()
        if days < 0 {
            return "дедлайн истек"
        } else {
            switch days {
            case 0:
                return "сегодня дедлайн"
            case 1:
                return "\(daysLeft()) день до дедлайна"
            case 2...4:
                return "\(daysLeft()) дня до дедлайна"
            default:
                return "\(daysLeft()) дней до дедлайна"
            }
        }
    }
    
    func textColor() -> Color {
        let days = daysLeft()
        if days < 3 {
            return .red
        } else {
            return .gray
        }
    }
}
