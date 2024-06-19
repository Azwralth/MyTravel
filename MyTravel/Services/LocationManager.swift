//
//  LocationManager.swift
//  MyTravel
//
//  Created by Владислав Соколов on 19.06.2024.
//

import SwiftUI
import CoreLocation

@Observable
class LocationManager: NSObject, CLLocationManagerDelegate {
  @ObservationIgnored let manager = CLLocationManager()
    var userLocation: CLLocation?
    var isAuthorized = false
    
    override init() {
        super.init()
        manager.delegate = self
        startLocationServices()
    }
    
    func startLocationServices() {
        if manager.authorizationStatus == .authorizedAlways || manager.authorizationStatus == .authorizedWhenInUse {
            manager.startUpdatingLocation()
            isAuthorized = true
        } else {
            isAuthorized = false
            manager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations.last
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            isAuthorized = true
            manager.requestLocation()
        case .notDetermined:
            isAuthorized = false
            manager.requestWhenInUseAuthorization()
        case .denied:
            isAuthorized = false
            print("access denied")
        default:
            isAuthorized = true
            startLocationServices()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
