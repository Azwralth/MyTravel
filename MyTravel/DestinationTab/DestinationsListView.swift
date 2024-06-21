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
        NavigationStack(path: $path) {
            Group {
                if !destinations.isEmpty {
                    List(destinations) { destination in
                        NavigationLink(value: destination) {
                            DestinationCellView(destination: destination)
                        }
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                modelContext.delete(destination)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                    .background(.darkBlue)
                    .navigationDestination(for: Destination.self) { destination in
                        DestinationLocationsMapView(destination: destination)
                    }
                } else {
                    DefaultContentView(name: "Нет доступных маршрутов")
                }
            }
            .navigationTitle("My Destinations")
            .navigationBarTitleTextColor(.white)
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
