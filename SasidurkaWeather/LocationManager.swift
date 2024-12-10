//  Sasidurka Venkatesan - 991542294
//  LocationManager.swift
//  SasidurkaWeather
//
//  Created by Sasidurka on 2024-11-28.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var location: CLLocationCoordinate2D?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let loc = locations.first {
            print("Location updated: \(loc.coordinate.latitude), \(loc.coordinate.longitude)")
            location = loc.coordinate
        } else {
            print("No location available")
        }
    }
}
