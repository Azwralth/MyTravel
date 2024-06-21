//
//  MainView.swift
//  MyTravel
//
//  Created by Владислав Соколов on 18.06.2024.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            Group {
//                TripMapView()
//                    .tabItem {
//                        Image(systemName: "map")
//                        Text("Map")
//                    }
                
                NoteView()
                    .tabItem {
                        Image(systemName: "note")
                        Text("Notes")
                    }
                FinancialTripView()
                    .tabItem {
                        Image(systemName: "airplane")
                        Text("Trips")
                    }
                DestinationsListView()
                    .tabItem {
                        Image(systemName: "globe")
                        Text("Places")
                    }
            }
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarBackground(.darkBlue.opacity(0.8), for: .tabBar)
        }
    }
}

#Preview {
    MainView()
}
