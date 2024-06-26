//
//  NoteView.swift
//  MyTravel
//
//  Created by Владислав Соколов on 18.06.2024.
//

import SwiftUI
import SwiftData

struct NoteView: View {
    @StateObject var viewModel: NoteViewModel
    
    @Environment(\.modelContext) private var modelContext
    @Query private var notes: [Note]
    
    var sortedNotes: [Note] {
        if viewModel.isSortedDate {
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
                            Button {
                                viewModel.selectedNote = note
                            } label: {
                                NoteCellView(note: note)
                            }
                            .listRowBackground(CustomColors.darkBlue)
                            .listRowInsets(EdgeInsets())
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    modelContext.delete(note)
                                } label: {
                                    Image(systemName: "trash")
                                }
                            }
                        }
                    }
                    .listRowSpacing(8)
                    .listStyle(.insetGrouped)
                    .scrollContentBackground(.hidden)
                    .padding(.leading, -5)
                } else {
                        VStack {
                            Spacer()
                            DefaultContentView(name: "No available notes")
                            Spacer()
                        }
                }
            }
            .background(CustomColors.darkBlue)
            .ignoresSafeArea(.keyboard)
            .navigationTitle("Notes")
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button(action: {
                        withAnimation {
                            viewModel.isSortedDate.toggle()
                        }
                    }) {
                        Image(systemName: viewModel.showTextSort())
                    }
                    Button(action: {
                        viewModel.showCreateNoteView = true
                    }) {
                        Image(systemName: "plus.circle.fill")
                    }
                }
            }
            .navigationDestination(item: $viewModel.selectedNote) { note in
                DetailNoteView(note: note)
            }
            .fullScreenCover(isPresented: $viewModel.showCreateNoteView) {
                CreateNoteView()
            }
        }
    }
}

#Preview {
    NoteView(viewModel: NoteViewModel())
}
