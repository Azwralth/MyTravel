//
//  LaunchViewModel.swift
//  MyTravel
//
//  Created by Владислав Соколов on 18.06.2024.
//

import Foundation

class LaunchViewModel: ObservableObject {
    @Published var currentPage: PageNumber = .first
    
    func getTitle() -> String {
        switch currentPage {
        case .first:
            return "Explore new places"
        case .second:
            return "Plan your trip"
        case .third:
            return "Apps for travel"
        }
    }
    
    func getSubTitle() -> String {
        switch currentPage {
        case .first:
            return "Find your next adventure"
        case .second:
            return "Book your flights and hotels"
        case .third:
            return "Add new note"
        }
    }
    
    func switchCurrentPage() {
        switch currentPage {
        case .first:
            currentPage = .second
        case .second:
            currentPage = .third
        case .third:
            currentPage = .first
        }
    }
}


enum PageNumber {
    case first
    case second
    case third
}

