//
//  EditNoteViewModel.swift
//  MyTravel
//
//  Created by Владислав Соколов on 22.06.2024.
//

import Foundation

final class EditNoteViewModel: ObservableObject {
    @Published var isValid = false
    @Published var showingDeadlinePicker = false
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
}
