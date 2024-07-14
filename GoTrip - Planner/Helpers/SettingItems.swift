//
//  SettingItems.swift
//  GoTrip - Planner
//
//  Created by Владислав Соколов on 11.07.2024.
//

import Foundation

enum Icons: String, CaseIterable {
    case share = "square.and.arrow.up.fill"
    case star = "star.fill"
    case reset = "arrow.2.circlepath.circle"
    
    var buttonName: String {
        switch self {
        case .share: "Share App"
        case .star: "Rate App"
        case .reset: "Reset Progress"
        }
    }
}
