//
//  DetailNoteViewModel.swift
//  MyTravel
//
//  Created by Владислав Соколов on 22.06.2024.
//

import Foundation
import UIKit

final class DetailNoteViewModel: ObservableObject {
    @Published var note: Note
    @Published var isShowEditView = false
    
    init(note: Note) {
        self.note = note
    }
    
    var annotationTitle: String {
        note.annotation.title
    }
    
    var detailText: String {
        note.detail
    }

    
    var formattedDate: String {
        note.date.formatted()
    }
}
