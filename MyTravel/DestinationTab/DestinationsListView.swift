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
            ZStack {
                Group {
                    if !destinations.isEmpty {
                        LazyVGrid(columns: [GridItem(.fixed(170), spacing: 20), GridItem(.fixed(170))], spacing: 15) {
                            ForEach(destinations) { destination in
                                NavigationLink(destination: DestinationLocationsMapView(destination: destination)) {
                                    DestinationCellView(destination: destination)
                                }
                            }
                        }
                        .scrollContentBackground(.hidden)
                        .background(.darkBlue)
                    } else {
                        ContentUnavailableView(
                            "No Destinations",
                            systemImage: "globe.desk",
                            description: Text("You have not set up any destinations yet.  Tap on the \(Image(systemName: "plus.circle.fill")) button in the toolbar to begin.")
                        )
                    }
                }
                .background(.darkBlue)
                .navigationBarTitleTextColor(.white)
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
}

#Preview {
    DestinationsListView()
        .modelContainer(Destination.preview)
}
