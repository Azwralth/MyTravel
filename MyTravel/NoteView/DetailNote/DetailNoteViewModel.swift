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
    @Published var isShowingImage = false
    @Published var isShowingShareSheet = false
    @Published var isShowEditView = false
    @Published var isImageExpanded = false
    
    init(note: Note) {
        self.note = note
    }
    
    var annotationTitle: String {
        note.annotation.title
    }
    
    var detailText: String {
        note.detail
    }
    
    var shouldShowImage: Bool {
        !(note.image?.isEmpty ?? true)
    }
    
    func toggleImage() {
        isShowingImage.toggle()
    }
    
    var imageButtonText: String {
        isShowingImage ? "Скрыть изображения" : "Показать изображение"
    }
    
    var uiImage: UIImage? {
        guard let imageData = note.image else { return nil }
        return UIImage(data: imageData)
    }
    
    var formattedDate: String {
        note.date.formatted()
    }
}
