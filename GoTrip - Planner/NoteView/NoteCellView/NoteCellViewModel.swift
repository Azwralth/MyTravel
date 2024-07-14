//
//  NoteCellViewModel.swift
//  MyTravel
//
//  Created by Владислав Соколов on 22.06.2024.
//

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
            return "Deadline has passed"
        } else {
            switch days {
            case 0:
                return "Deadline is today"
            case 1:
                return "\(daysLeft()) day until the deadline"
            default:
                return "\(daysLeft()) days until the deadline"
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
