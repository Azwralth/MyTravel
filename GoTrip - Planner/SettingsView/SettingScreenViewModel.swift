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
        let modelsToDelete: [any PersistentModel.Type] = [Trip.self, Note.self, Destination.self, MTPlacemark.self]
        
        do {
            for model in modelsToDelete {
                try modelContext.delete(model: model)
            }
            print("All data successfully deleted.")
        } catch {
            print("Failed to delete all data.")
        }
    }
}
