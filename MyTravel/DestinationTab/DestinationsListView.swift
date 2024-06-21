//
//  DestinationsListView.swift
//  MyTravel
//
//  Created by Владислав Соколов on 19.06.2024.
//

import SwiftUI
import SwiftData

struct DestinationsListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Destination.name) private var destinations: [Destination]
    @State private var newDestination = false
    @State private var destinationName = ""
    @State private var path = NavigationPath()
    
    var body: some View {
            NavigationStack {
                VStack {
                    if !destinations.isEmpty {
                        List {
                            ForEach(destinations) { destination in
                                NavigationLink {
                                    DestinationLocationsMapView(destination: destination)
                                } label: {
                                    DestinationCellView(destination: destination)
                                }
                                .listRowSeparator(.hidden)
                                .listRowBackground(CustomColors.darkBlue)
                                .listRowInsets(EdgeInsets())
                                .swipeActions(edge: .trailing) {
                                    Button(role: .destructive) {
                                        modelContext.delete(destination)
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                            }
                        }
                        .listRowSpacing(8)
                        .listStyle(.insetGrouped)
                        .scrollContentBackground(.hidden)
                        .padding(.leading, -5)
                    } else {
                        DefaultContentView(name: "Нет доступных маршрутов")
                    }
                }
                
                .background(.darkBlue)
                .navigationTitle("My Destinations")
                .toolbar {
                    Button {
                        newDestination.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                    .alert(
                        "Enter Destination Name",
                        isPresented: $newDestination) {
                            TextField("Enter destination name", text: $destinationName)
                                .autocorrectionDisabled()
                            Button("OK") {
                                if !destinationName.isEmpty {
                                    let destination = Destination(name: destinationName.trimmingCharacters(in: .whitespacesAndNewlines))
                                    modelContext.insert(destination)
                                    destinationName = ""
                                    path.append(destination)
                                }
                            }
                            Button("Cancel", role: .cancel) {}
                        } message: {
                            Text("Create a new destination")
                        }
                }
            }
        }
    }

#Preview {
    DestinationsListView()
        .modelContainer(Destination.preview)
}
