//
//  MyTravelApp.swift
//  MyTravel
//
//  Created by Владислав Соколов on 18.06.2024.
//

import SwiftUI
import SwiftData

@main
struct MyTravelApp: App {
    @State private var locationManager = LocationManager()
    @StateObject var lnManager = LocalNotificationManager()
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Note.self,
            Trip.self,
            MTPlacemark.self,
            Destination.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(lnManager)
        }
        .modelContainer(sharedModelContainer)
    }
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(CustomColors.darkBlue)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        appearance.shadowColor = UIColor.clear
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
    }
}
