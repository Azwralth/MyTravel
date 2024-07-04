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
    @EnvironmentObject var lnManager: LocalNotificationManager
    
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
                            .padding(.horizontal)
                        
                        HStack {
                            Text("Deadline:")
                                .foregroundStyle(.gray)
                            Spacer()
                                DatePicker("", selection: $note.deadline)
                                    .colorScheme(.dark)
                                    .padding(.trailing, 10)
                                    .tint(.white)
                        }
                        .padding(.leading, 20)
                        .frame(minHeight: 65)
                        .background(CustomColors.darkBlue)
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(.gray, lineWidth: 1))
                        .padding(.horizontal)
                        
                        Spacer()
                        
                        Button(action: {
                            lnManager.clearRequests()
                            Task {
                                let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: note.deadline)
                                let localNotification = LocalNotification(
                                    identifier: UUID().uuidString,
                                    title: note.name,
                                    body: "Deadline now",
                                    dateComponents: dateComponents,
                                    repeats: false
                                )
                                await lnManager.schedule(localNotification: localNotification)
                            }
                        }) {
                            Text("Set new Deadline")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .foregroundColor(.white)
                        }
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .padding()
                        .padding(.top, -15)
                        
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
                }
                .background(.darkBlue)
            }
        }
    }
}

#Preview {
    EditNoteView(note: .constant(Note(name: "Страховка", detail: "Сделать страховку онлайн", annotation: .hotel, date: .now, deadline: .now)))
        .environmentObject(LocalNotificationManager())
}

