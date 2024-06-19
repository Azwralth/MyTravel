//
//  Destination.swift
//  MyTravel
//
//  Created by Владислав Соколов on 19.06.2024.
//

import SwiftData
import MapKit

@Model
class Destination {
    var name: String
    var latitude: Double?
    var longitude: Double?
    var latitudeDelta: Double?
    var longitudeDelta: Double?
    @Relationship(deleteRule: .cascade)
    var placemarks: [MTPlacemark] = []
    
    init(name: String, latitude: Double? = nil, longitude: Double? = nil, latitudeDelta: Double? = nil, longitudeDelta: Double? = nil) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.latitudeDelta = latitudeDelta
        self.longitudeDelta = longitudeDelta
    }
    
    var region: MKCoordinateRegion? {
        if let latitude, let longitude, let latitudeDelta, let longitudeDelta {
            return MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
                span: MKCoordinateSpan(latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta)
            )
        } else {
            return nil
        }
    }
}

extension Destination {
    @MainActor
    static var preview: ModelContainer {
        let container = try! ModelContainer(
            for: Destination.self,
            configurations: ModelConfiguration(
                isStoredInMemoryOnly: true
            )
        )
//        let paris = CLLocationCoordinate2D(latitude: 48.856788, longitude: 2.351077)
//        let parisSpan = MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)
        let paris = Destination(
            name: "Paris",
            latitude: 48.856788,
            longitude: 2.351077,
            latitudeDelta: 0.15,
            longitudeDelta: 0.15
        )
        container.mainContext.insert(paris)
        var placeMarks: [MTPlacemark] {
            [
                MTPlacemark(name: "Louvre Museum", address: "93 Rue de Rivoli, 75001 Paris, France", latitude: 48.861950, longitude: 2.336902),
                MTPlacemark(name: "Sacré-Coeur Basilica", address: "Parvis du Sacré-Cœur, 75018 Paris, France", latitude: 48.886634, longitude: 2.343048),
                MTPlacemark(name: "Eiffel Tower", address: "5 Avenue Anatole France, 75007 Paris, France", latitude: 48.858258, longitude: 2.294488),
                MTPlacemark(name: "Moulin Rouge", address: "82 Boulevard de Clichy, 75018 Paris, France", latitude: 48.884134, longitude: 2.332196),
                MTPlacemark(name: "Arc de Triomphe", address: "Place Charles de Gaulle, 75017 Paris, France", latitude: 48.873776, longitude: 2.295043),
                MTPlacemark(name: "Gare Du Nord", address: "Paris, France", latitude: 48.880071, longitude: 2.354977),
                MTPlacemark(name: "Notre Dame Cathedral", address: "6 Rue du Cloître Notre-Dame, 75004 Paris, France", latitude: 48.852972, longitude: 2.350004),
                MTPlacemark(name: "Panthéon", address: "Place du Panthéon, 75005 Paris, France", latitude: 48.845616, longitude: 2.345996),
            ]
        }
        placeMarks.forEach {placemark in
            paris.placemarks.append(placemark)
        }
        return container
    }
}
