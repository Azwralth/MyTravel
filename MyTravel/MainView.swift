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
            NoteView()
                .tabItem {
                    Image(systemName: "note")
                    Text("Notes")
                }
                .tag(1)
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarBackground(.darkBlue.opacity(0.8), for: .tabBar)
            
            FinancialTripView()
                .tabItem {
                    Image(systemName: "2.square.fill")
                    Text("Second")
                }
                .tag(2)
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarBackground(.darkBlue.opacity(0.8), for: .tabBar)
        }
    }
}

#Preview {
    MainView()
}
