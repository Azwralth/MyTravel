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
                    if trips.isEmpty {
                        Color.darkBlue
                            .overlay(
                                DefaultContentView(name: "Нет доступных путешествий")
                            )
                            .padding(.top, 300)
                    } else {
                        LazyVGrid(columns: [GridItem(.fixed(170), spacing: 20), GridItem(.fixed(170))], spacing: 15) {
                            ForEach(trips) { trip in
                                NavigationLink(destination: DetailTripView(trip: trip)) {
                                    TripCellView(trip: trip)
                                }
                            }
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .navigationBarTitleTextColor(.white)
                .background(Color.darkBlue)
                .navigationTitle("Trips")
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

struct FinancialTripView_Previews: PreviewProvider {
    static var previews: some View {
        FinancialTripView()
    }
}

