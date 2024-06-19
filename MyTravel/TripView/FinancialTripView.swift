//
//  FinancialTripView.swift
//  MyTravel
//
//  Created by Владислав Соколов on 18.06.2024.
//

import SwiftUI
import SwiftData

struct FinancialTripView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var trips: [Trip]
    @State private var showCreateTripView = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    LazyVGrid(columns: [
                        GridItem(.adaptive(minimum: 200)),
                        GridItem(.adaptive(minimum: 200))
                    ], spacing: 11) {
                        ForEach(trips) { trip in
                            NavigationLink {
                                DetailTripView(trip: trip)
                            } label: {
                                TripCellView(trip: trip)
                            }
                            .listRowSeparator(.hidden)
                            .listRowBackground(CustomColors.darkBlue)
                            .listRowInsets(EdgeInsets())
                        }
                    }
                    .padding([.leading, .trailing], 10)
                    
                    .toolbar {
                        ToolbarItem {
                            Button(action: {
                                showCreateTripView = true
                            }) {
                                Label("Add Trip", systemImage: "plus.circle.fill")
                            }
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .navigationBarTitleTextColor(.white)
                .background(.darkBlue)
                .navigationTitle("Trips")
            }
            .fullScreenCover(isPresented: $showCreateTripView) {
                CreateTripView()
            }
        }
    }
    
    private func deleteTrip(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(trips[index])
            }
        }
    }
}

#Preview {
    FinancialTripView()
}
