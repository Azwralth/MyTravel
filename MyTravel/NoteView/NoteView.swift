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
    @State private var isSortedDate = false
    
    var sortedNotes: [Note] {
        if isSortedDate {
            return notes.sorted(by: { $0.date > $1.date })
        } else {
            return notes
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if !notes.isEmpty {
                    List {
                        ForEach(sortedNotes) { note in
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
                            DefaultContentView(name: "Нет доступных заметок")
                                .offset(y: 200)
                            Spacer()
                        }
                    }
                }
            }
            .background(.darkBlue)
            .navigationTitle("Notes")
            .navigationBarTitleTextColor(.white)
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button(action: {
                        withAnimation {
                            isSortedDate.toggle()
                        }
                    }) {
                        Image(systemName: isSortedDate ? "arrow.up.arrow.down.circle.fill" : "arrow.up.arrow.down.circle")
                    }
                    Button(action: {
                        showCreateNoteView = true
                    }) {
                        Image(systemName: "plus.circle.fill")
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
