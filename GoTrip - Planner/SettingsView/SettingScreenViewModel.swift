//
//  SettingScreenViewModel.swift
//  GoTrip - Planner
//
//  Created by Владислав Соколов on 11.07.2024.
//

import SwiftUI
import StoreKit
import SwiftData

final class SettingScreenViewModel: ObservableObject {
    private(set) var menuIcons: [Icons] = Icons.allCases
    private var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func performAction(for icon: Icons) {
        switch icon {
        case .share:
            shareApp()
        case .star:
            rateApp()
        case .reset:
            resetProgress()
        }
    }
    
    func shareApp() {
        guard let url = URL(string: "https://apps.apple.com/at/app/gotrip-planner/id6504802309") else { return }
        let activityController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        windowScene?.keyWindow?.rootViewController?.present(activityController, animated: true)
    }
    
    func rateApp() {
        let scenes = UIApplication.shared.connectedScenes
        if let windowScene = scenes.first as? UIWindowScene {
            SKStoreReviewController.requestReview(in: windowScene)
        }
    }
    
    func resetProgress() {
        do {
            try modelContext.delete(model: Trip.self)
            try modelContext.delete(model: Note.self)
            try modelContext.delete(model: Destination.self)
            try modelContext.delete(model: MTPlacemark.self)
        } catch {
            print("Failed to delete all schools.")
        }
    }
}
