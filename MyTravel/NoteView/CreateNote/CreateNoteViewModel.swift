//
//  CreateNoteViewModel.swift
//  MyTravel
//
//  Created by Владислав Соколов on 22.06.2024.
//

import SwiftUI
import PhotosUI
import SwiftData

class CreateNoteViewModel: ObservableObject {
    @Published var name = ""
    @Published var detail = ""
    @Published var annotation: Annotation = .flight
    @Published var deadline = Date()
    @Published var isValid = false
    @Published var selectedImage: PhotosPickerItem? = nil
    @Published var imageData: Data? = nil
    @Published var isShowDeadlinePicker = false
    
    init() {
        updateValidity()
    }
    
    func showDeadLinePicker() {
        isShowDeadlinePicker.toggle()
    }
    
    func updateValidity() {
        isValid = !name.isEmpty && !detail.isEmpty
    }
    
    func saveNote(modelContext: ModelContext, presentationMode: Binding<PresentationMode>) {
        let newNote = Note(name: name, detail: detail, annotation: annotation, date: .now, image: imageData, deadline: deadline)
        modelContext.insert(newNote)
        presentationMode.wrappedValue.dismiss()
    }
    
    func loadImageData() {
        guard let selectedImage = selectedImage else { return }
        selectedImage.loadTransferable(type: Data.self) { result in
            if case .success(let data) = result {
                self.imageData = data
            }
        }
    }
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
}
