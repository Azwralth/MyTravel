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
            ZStack {
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
                    }
                    .onDelete(perform: deleteNotes)
                }
                .listRowSpacing(8)
                .listStyle(.insetGrouped)
                .scrollContentBackground(.hidden)
                .navigationBarTitleTextColor(.white)
                .background(.darkBlue)
                .navigationTitle("Notes")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                    ToolbarItem {
                        Button(action: {
                            showCreateNoteView = true
                        }) {
                            Label("Add Note", systemImage: "plus.circle.fill")
                        }
                    }
                }
            }
            .fullScreenCover(isPresented: $showCreateNoteView) {
                CreateNoteView()
            }
        }
    }
    
    private func deleteNotes(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(notes[index])
            }
        }
    }
}

#Preview {
    NoteView()
}
