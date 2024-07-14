//
//  MainView.swift
//  MyTravel
//
//  Created by Владислав Соколов on 18.06.2024.
//

import SwiftUI
import SwiftData

struct MainView: View {
    
    var body: some View {
        TabView {
            Group {
                NoteView(viewModel: NoteViewModel())
                    .tabItem {
                        Image(systemName: "note")
                        Text("Notes")
                    }
                TripView()
                    .tabItem {
                        Image(systemName: "airplane")
                        Text("Trips")
                    }
                DestinationsListView()
                    .tabItem {
                        Image(systemName: "globe")
                        Text("Places")
                    }
                
                SettingScreenView()
                    .tabItem {
                        Image(systemName: "gearshape")
                        Text("Settings")
                    }
            }
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarBackground(CustomColors.darkBlue.opacity(0.8), for: .tabBar)
        }
    }
}
