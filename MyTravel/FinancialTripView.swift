//
//  FinancialTripView.swift
//  MyTravel
//
//  Created by Владислав Соколов on 18.06.2024.
//

import SwiftUI
import SwiftData

//struct FinancialTripView: View {
//    @Query private var trips: [Trip]
//
//    var body: some View {
//        NavigationStack {
//            ZStack {
//                List {
//                    ForEach(trips) { trip in
//                        NavigationLink {
//                            Text(trip.name)
//                        } label: {
//                            NoteCellView(note: note)
//                        }
//                        .listRowSeparator(.hidden)
//                        .listRowBackground(CustomColors.darkBlue)
//                        .listRowInsets(EdgeInsets())
//                    }
//                    .onDelete(perform: deleteNotes)
//                }
//                .listRowSpacing(8)
//                .listStyle(.insetGrouped)
//                .scrollContentBackground(.hidden)
//                .navigationBarTitleTextColor(.white)
//                .background(.darkBlue)
//                .navigationTitle("Notes")
//                .toolbar {
//                    ToolbarItem(placement: .navigationBarTrailing) {
//                        EditButton()
//                    }
//                    ToolbarItem {
//                        Button(action: {
//                            showCreateNoteView = true
//                        }) {
//                            Label("Add Note", systemImage: "plus.circle.fill")
//                        }
//                    }
//                }
//            }
//            .fullScreenCover(isPresented: $showCreateNoteView) {
//                CreateNoteView()
//            }
//        }
//    }
//
//    private func deleteNotes(offsets: IndexSet) {
//        withAnimation {
//            for index in offsets {
//                modelContext.delete(notes[index])
//            }
//        }
//    }
//}
//
//#Preview {
//    FinancialTripView()
//}
