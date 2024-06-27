//
//  FinancialTripView.swift
//  MyTravel
//
//  Created by Владислав Соколов on 18.06.2024.
//

import SwiftUI
import SwiftData

struct TripView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var trips: [Trip]
    @State private var showCreateTripView = false
    @State private var selectedTrip: Trip? = nil
    
    var body: some View {
        NavigationStack {
            VStack {
                if !trips.isEmpty {
                    List {
                        ForEach(trips) { trip in
                            Button {
                                selectedTrip = trip
                            } label: {
                                TripCellView(trip: trip)
                            }
                            .listRowBackground(CustomColors.darkBlue)
                            .listRowInsets(EdgeInsets())
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    modelContext.delete(trip)
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
                        DefaultContentView(name: "No available trips")
                        Spacer()
                    }
                }
            }
            .background(CustomColors.darkBlue)
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
            .navigationDestination(item: $selectedTrip) { trip in
                DetailTripView(trip: trip)
            }
        }
        .fullScreenCover(isPresented: $showCreateTripView) {
            CreateTripView()
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
    TripView()
}

