//
//  CreateNoteView.swift
//  MyTravel
//
//  Created by Владислав Соколов on 18.06.2024.
//

import SwiftUI

struct CreateNoteView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) private var presentationMode
    
    @State private var name = ""
    @State private var detail = ""
    @State private var annotation: Annotation = .flight
    @State private var isValid = false
    
    let rows: [GridItem] = [
        GridItem(.fixed(20))
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                CustomTextField(text: $name, field: Field.name.title)
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
                .padding(.bottom, 105)
                
                CustomTextField(text: $detail, field: Field.detail.title)
                    .onChange(of: detail) { _, newValue in
                        isValid = !newValue.isEmpty && !name.isEmpty
                    }
                    .padding(.horizontal)
                    .padding(.top, -105)
                
                Spacer()
                
                Button(action: {
                    let newNote = Note(name: name, detail: detail, annotation: annotation)
                    modelContext.insert(newNote)
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text(Field.add.title)
                }
                .frame(width: 350, height: 60)
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .opacity(!isValid ? 0.3 : 1)
                .disabled(!isValid)
                .padding(.horizontal)
            }
            .navigationTitle(Field.mainTitle.title)
            .navigationBarTitleTextColor(.white)
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

struct CustomTextField: View {
    @Binding var text: String
    var field: String
    
    var body: some View {
        TextField(text: $text) {
            Text(field)
                .foregroundStyle(.gray)
        }
        .padding(.leading, 20)
        .frame(minHeight: 65)
        .foregroundStyle(.white)
        .overlay(RoundedRectangle(cornerRadius: 20).stroke(.gray, lineWidth: 1))
        .padding(.vertical, 4)
    }
}

enum Field {
    case name
    case detail
    case add
    case mainTitle
    
    var title: String {
        switch self {
        case .name:
            "Name"
        case .detail:
            "Detail"
        case .add:
            "Add"
        case .mainTitle:
            "New Note"
        }
    }
}

#Preview {
    CreateNoteView()
}
