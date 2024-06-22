//
//  DetailNoteViewModel.swift
//  MyTravel
//
//  Created by Владислав Соколов on 22.06.2024.
//

import Foundation

final class DetailNoteViewModel: ObservableObject {
    @Published var note: Note
    @Published var isShowingImage = false
    @Published var isShowingShareSheet = false
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
    
    var imageButtonText: String {
        isShowingImage ? "Скрыть изображения" : "Показать изображение"
    }
    
    var shareButtonText: String {
        "Поделиться"
    }
    
    var formattedDate: String {
        note.date.formatted()
    }
}
