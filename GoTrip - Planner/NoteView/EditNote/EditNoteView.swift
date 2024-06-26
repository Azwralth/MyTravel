//
//  EditNoteView.swift
//  MyTravel
//
//  Created by Владислав Соколов on 22.06.2024.
//

import SwiftUI

struct EditNoteView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) private var presentationMode
    
    @StateObject var viewModel = EditNoteViewModel()
    @State private var isValid = false
    @State private var showingDeadlinePicker = false
    
    @Binding var note: Note
    
    init(note: Binding<Note>) {
        self._note = note
    }
    
    let rows: [GridItem] = [
        GridItem(.fixed(30))
    ]
    
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                ScrollView {
                    VStack(spacing: 7) {
                        CustomTextField(text: $note.name, field: "Name")
                            .onChange(of: note.name) { _, newValue in
                                isValid = !newValue.isEmpty && !note.detail.isEmpty
                            }
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal) {
                            LazyHGrid(rows: rows) {
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
                        
                        CustomTextField(text: $note.detail, field: "Detail")
                            .onChange(of: note.detail) { _, newValue in
                                isValid = !newValue.isEmpty && !note.name.isEmpty
                            }
                            .padding(.horizontal)
                        
                        Button(action: {
                            showingDeadlinePicker.toggle()
                        }) {
                            HStack {
                                Text("Deadline: \(note.deadline, formatter: viewModel.dateFormatter)")
                                    .foregroundStyle(.gray)
                                Spacer()
                                Image(systemName: "calendar")
                                    .foregroundStyle(.gray)
                                    .padding()
                            }
                        }
                        .padding(.leading, 20)
                        .frame(minHeight: 65)
                        .background(CustomColors.darkBlue)
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(.gray, lineWidth: 1))
                        .padding(.horizontal)
                        
                        Spacer()
                        
                    }
                    .navigationTitle("Edit Note")
                    .background(CustomColors.darkBlue)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
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
                .background(.darkBlue)
            }
        }
    }
}

#Preview {
    EditNoteView(note: .constant(Note(name: "Страховка", detail: "Сделать страховку онлайн", annotation: .hotel, date: .now, deadline: .now)))
}

