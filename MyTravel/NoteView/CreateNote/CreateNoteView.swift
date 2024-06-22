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
    
    @StateObject private var viewModel = CreateNoteViewModel()
    
    let rows: [GridItem] = [
        GridItem(.fixed(30))
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                CustomTextField(text: $viewModel.name, field: "Name")
                    .onChange(of: viewModel.name) { _, newValue in
                        viewModel.updateValidity()
                    }
                    .padding(.horizontal)
                
                ScrollView(.horizontal) {
                    LazyHGrid(rows: rows, spacing: 10) {
                        ForEach(Annotation.allCases) { annotation in
                            Button(action: {
                                viewModel.annotation = annotation
                            }) {
                                Text(annotation.title)
                                    .font(.system(size: 14))
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5)
                                    .background(.blue)
                                    .foregroundColor(.white)
                                    .opacity(viewModel.annotation == annotation ? 1 : 0.4)
                                    .cornerRadius(16)
                                    .offset(x: 16)
                            }
                        }
                    }
                    .padding(.trailing, 35)
                }
                .scrollIndicators(.hidden)
                .padding(.bottom, 90)
                
                CustomTextField(text: $viewModel.detail, field: "Detail")
                    .onChange(of: viewModel.detail) { _, newValue in
                        viewModel.updateValidity()
                    }
                    .padding(.horizontal)
                    .padding(.top, -90)
                
                Button(action: viewModel.showDeadLinePicker) {
                    HStack {
                        Text("Deadline: \(viewModel.deadline, formatter: viewModel.dateFormatter)")
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
                
                PhotosPicker("Add Image", selection: $viewModel.selectedImage, matching: .images)
                    .onChange(of: viewModel.selectedImage) { _, newValue in
                        if let selectedImage = viewModel.selectedImage {
                            selectedImage.loadTransferable(type: Data.self) { result in
                                switch result {
                                case .success(let data):
                                    viewModel.imageData = data
                                case .failure(let error):
                                    print(error)
                                }
                            }
                        }
                    }
                    .offset(x: -130)
                
                if let imageData = viewModel.imageData {
                    Image(uiImage: UIImage(data: imageData)!)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .padding(.leading, -165)
                }
                
                Spacer()
                
                Button(action: {
                    viewModel.saveNote(modelContext: modelContext, presentationMode: presentationMode)
                }) {
                    Text("Add")
                }
                .frame(width: 350, height: 60)
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .opacity(!viewModel.isValid ? 0.3 : 1)
                .disabled(!viewModel.isValid)
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
            .sheet(isPresented: $viewModel.isShowDeadlinePicker) {
                VStack {
                    DatePicker("Deadline", selection: $viewModel.deadline, displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding()
                    Button("Done") {
                        viewModel.showDeadLinePicker()
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    CreateNoteView()
}
