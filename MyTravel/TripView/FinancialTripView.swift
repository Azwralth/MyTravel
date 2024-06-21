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
            VStack {
                ScrollView {
                    if !trips.isEmpty {
                        LazyVGrid(columns: [GridItem(.fixed(170), spacing: 20), GridItem(.fixed(170))], spacing: 15) {
                            ForEach(trips) { trip in
                                NavigationLink(destination: DetailTripView(trip: trip)) {
                                    TripCellView(trip: trip)
                                }
                            }
                        }
                    } else {
                        VStack {
                            Spacer()
                            DefaultContentView(name: "Нет доступных путешествий")
                                .offset(y: 200)
                            Spacer()
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
                            Image(systemName: "plus.circle.fill")
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

#Preview {
    FinancialTripView()
}

