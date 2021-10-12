//
//  LocationManager.swift
//  weatherfun
//
//  Created by Justin Bengtson on 9/23/21.
//

import Foundation
import CoreLocation

class LocationManager: NSObject {
    static let shared = LocationManager()
    
    private let locationManager = CLLocationManager()
    private var completion: ((CLPlacemark?) -> Void)?
    
    public func getUserLocation(completion: @escaping (CLPlacemark?) -> (Void)) {
        self.completion = completion
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    private func resolveLocationName(with location: CLLocation, completionHandler: @escaping (CLPlacemark?) -> Void) {
        let geoCoder = CLGeocoder()
        
        geoCoder.reverseGeocodeLocation(location) { placemarks, error in
            guard let place = placemarks?.first, error == nil else {
                completionHandler(nil)
                return
            }
            
            completionHandler(place)
            
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let firstLocation = locations.first, let completion = self.completion else { return }
        resolveLocationName(with: firstLocation, completionHandler: completion)
        manager.stopUpdatingLocation()
    }
}
