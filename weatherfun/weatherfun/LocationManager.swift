//
//  LocationManager.swift
//  weatherfun
//
//  Created by Justin Bengtson on 9/23/21.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = LocationManager()
    
    let locationManager = CLLocationManager()
    
    var completion: ((CLLocation) -> Void)?
    
    public func getUserLocation(completion: @escaping (CLLocation) -> (Void)) {
        self.completion = completion
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    public func resolveLocationName(with location: CLLocation, completionHandler: @escaping (String?) -> Void) {
        let geoCoder = CLGeocoder()
        
        geoCoder.reverseGeocodeLocation(location) { placemarks, error in
            guard let place = placemarks?.first, error == nil else {
                self.completion?(location)
                return
            }
            
            var locationName = ""
            
            if let locality = place.locality {
                locationName = locality
            }
            
            completionHandler(locationName)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let firstLocation = locations.first else { return }
        completion?(firstLocation)
        manager.stopUpdatingLocation()
    }
}
