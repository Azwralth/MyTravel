//
//  NoteView.swift
//  MyTravel
//
//  Created by Владислав Соколов on 18.06.2024.
//

import SwiftUI
import SwiftData

struct NoteView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var notes: [Note]
    @State private var showCreateNoteView = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if !notes.isEmpty {
                    List {
                        ForEach(notes) { note in
                            NavigationLink {
                                DetailNoteView(note: note)
                            } label: {
                                NoteCellView(note: note)
                            }
                            .listRowSeparator(.hidden)
                            .listRowBackground(CustomColors.darkBlue)
                            .listRowInsets(EdgeInsets())
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    modelContext.delete(note)
                                } label: {
                                    Label("", systemImage: "trash")
                                }
                            }
                        }
                    }
                    .listRowSpacing(8)
                    .listStyle(.insetGrouped)
                    .scrollContentBackground(.hidden)
                    .padding(.leading, -5)
                    
                } else {
                    ScrollView {
                        VStack {
                            Spacer()
                            ZStack {
                                Color(CustomColors.darkBlue)
                                    .ignoresSafeArea()
                                DefaultContentView(name: "Нет доступных заметок")
                                    .offset(y: 200)
                            }
                            Spacer()
                        }
                    }
                }
            }
            .background(.darkBlue)
            .navigationTitle("Notes")
            .navigationBarTitleTextColor(.white)
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        showCreateNoteView = true
                    }) {
                        Label("Добавить заметку", systemImage: "plus.circle.fill")
                    }
                }
            }
            .fullScreenCover(isPresented: $showCreateNoteView) {
                CreateNoteView()
            }
        }
    }
}

#Preview {
    NoteView()
}
