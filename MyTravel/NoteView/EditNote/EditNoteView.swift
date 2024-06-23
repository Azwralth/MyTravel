//
//  EditNoteView.swift
//  MyTravel
//
//  Created by Владислав Соколов on 22.06.2024.
//

import SwiftUI
import PhotosUI

struct EditNoteView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) private var presentationMode
    
    @StateObject var viewModel = EditNoteViewModel()
    @State private var isValid = false
    @State private var showingDeadlinePicker = false
    @State private var selectedImage: PhotosPickerItem? = nil
    @State private var imageData: Data? = nil
    
    @Binding var note: Note
    
    init(note: Binding<Note>) {
        self._note = note
    }
    
    let rows: [GridItem] = [
        GridItem(.fixed(30))
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                CustomTextField(text: $note.name, field: "Name")
                    .onChange(of: note.name) { _, newValue in
                        isValid = !newValue.isEmpty && !note.detail.isEmpty
                    }
                    .padding(.horizontal)
                
                ScrollView(.horizontal) {
                    LazyHGrid(rows: rows, spacing: 10) {
                        ForEach(Annotation.allCases) { annotation in
                            Button(action: {
                                self.note.annotation = annotation
                            }) {
                                Text(annotation.title)
                                    .font(.system(size: 14))
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5)
                                    .background(.blue)
                                    .foregroundColor(.white)
                                    .opacity(self.note.annotation == annotation ? 1 : 0.4)
                                    .cornerRadius(16)
                                    .offset(x: 16)
                            }
                        }
                    }
                    .padding(.trailing, 35)
                }
                .scrollIndicators(.hidden)
                .padding(.bottom, 90)
                
                CustomTextField(text: $note.detail, field: "Detail")
                    .onChange(of: note.detail) { _, newValue in
                        isValid = !newValue.isEmpty && !note.name.isEmpty
                    }
                    .padding(.horizontal)
                    .padding(.top, -90)
                
                Button(action: {
                    showingDeadlinePicker.toggle()
                }) {
                    HStack {
                        Text("Deadline: \(note.deadline, formatter: dateFormatter)")
                            .foregroundStyle(.gray)
                        Spacer()
                        Image(systemName: "calendar")
                            .foregroundStyle(.gray)
                            .padding()
                    }
                }
                .padding(.leading, 20)
                .frame(minHeight: 65)
                .background(.darkBlue)
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(.gray, lineWidth: 1))
                .padding(.horizontal)
                .padding(.bottom, 10)
                .padding(.top, -10)
                
                PhotosPicker("Add Image", selection: $selectedImage, matching: .images)
                    .onChange(of: selectedImage) { _, newValue in
                        if let selectedImage = selectedImage {
                            selectedImage.loadTransferable(type: Data.self) { result in
                                switch result {
                                case .success(let data):
                                    imageData = data
                                case .failure(let error):
                                    print(error)
                                }
                            }
                        }
                    }
                    .offset(x: -130)
                
                if let imageData = imageData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .padding(.leading, -165)
                }
                
                Spacer()

            }
            .navigationTitle("Edit Note")
            .background(.darkBlue)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Close") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .sheet(isPresented: $showingDeadlinePicker) {
                VStack {
                    DatePicker("Deadline", selection: $note.deadline, displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding()
                    Button("Done") {
                        showingDeadlinePicker.toggle()
                    }
                    .padding()
                }
            }
        }
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
}

