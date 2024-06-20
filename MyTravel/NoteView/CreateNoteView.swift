//
//  CreateNoteView.swift
//  MyTravel
//
//  Created by Владислав Соколов on 18.06.2024.
//

import SwiftUI
import PhotosUI

struct CreateNoteView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) private var presentationMode
    
    @State private var name = ""
    @State private var detail = ""
    @State private var annotation: Annotation = .flight
    @State private var isValid = false
    @State private var selectedImage: PhotosPickerItem? = nil
    @State private var imageData: Data? = nil
    
    let rows: [GridItem] = [
        GridItem(.fixed(30))
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                CustomTextField(text: $name, field: "Name")
                    .onChange(of: name) { _, newValue in
                        isValid = !newValue.isEmpty && !detail.isEmpty
                    }
                    .padding(.horizontal)
                
                ScrollView(.horizontal) {
                    LazyHGrid(rows: rows, spacing: 10) {
                        ForEach(Annotation.allCases) { annotation in
                            Button(action: {
                                self.annotation = annotation
                            }) {
                                Text(annotation.title)
                                    .font(.system(size: 14))
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5)
                                    .background(.blue)
                                    .foregroundColor(.white)
                                    .opacity(self.annotation == annotation ? 1 : 0.4)
                                    .cornerRadius(16)
                                    .offset(x: 16)
                            }
                        }
                    }
                    .padding(.trailing, 35)
                }
                .scrollIndicators(.hidden)
                .padding(.bottom, 90)
                
                CustomTextField(text: $detail, field: "Detail")
                    .onChange(of: detail) { _, newValue in
                        isValid = !newValue.isEmpty && !name.isEmpty
                    }
                    .padding(.horizontal)
                    .padding(.top, -90)
                
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
                
                if let imageData {
                    Image(uiImage: UIImage(data: imageData)!)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .padding(.leading, -165)
                }
                
                Spacer()
                
                Button(action: {
                    let newNote = Note(name: name, detail: detail, annotation: annotation, date: .now, image: imageData)
                    modelContext.insert(newNote)
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Add")
                }
                .frame(width: 350, height: 60)
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .opacity(!isValid ? 0.3 : 1)
                .disabled(!isValid)
                .padding(.horizontal)
            }
            .navigationTitle("New Note")
            .background(.darkBlue)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    CreateNoteView()
}
