//
//  Note.swift
//  MyTravel
//
//  Created by Владислав Соколов on 18.06.2024.
//

import Foundation
import SwiftData

@Model
final class Note {
    let name: String
    let detail: String
    let annotation: Annotation
    let date: Date
    let image: Data?
    
    init(name: String, detail: String, annotation: Annotation, date: Date, image: Data?) {
        self.name = name
        self.detail = detail
        self.annotation = annotation
        self.date = date
        self.image = image
    }
}

enum Annotation: Codable, CaseIterable, Identifiable {
    case flight
    case hotel
    case restaurant
    case sightseeing
    case transportation
    case other
    
    var id: String { self.title }
    
    var title: String {
        switch self {
        case .flight:
            "Flight"
        case .hotel:
            "Hotel"
        case .restaurant:
            "Restaurant"
        case .sightseeing:
            "Sightseeing"
        case .transportation:
            "Transportation"
        case .other:
            "Other"
        }
    }
}
