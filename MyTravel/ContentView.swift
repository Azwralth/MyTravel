//
//  ContentView.swift
//  MyTravel
//
//  Created by Владислав Соколов on 18.06.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var showLaunchView = !UserDefaults.standard.bool(forKey: "hasLaunchedBefore")

    var body: some View {
        NavigationStack {
            MainView() // Основной вид вашего приложения
                .fullScreenCover(isPresented: $showLaunchView, onDismiss: {
                    UserDefaults.standard.set(true, forKey: "hasLaunchedBefore")
                }) {
                    LaunchView(showLaunchView: $showLaunchView)
                }
        }
    }
}
