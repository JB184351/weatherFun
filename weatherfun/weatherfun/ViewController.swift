//
//  ViewController.swift
//  weatherfun
//
//  Created by Justin Bengtson on 9/6/21.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        
//        WeatherAPI.getWeatherForOneLocation { weatherForOneLocation in
//            print(weatherForOneLocation)
//        }
        
        LocationManager.shared.getUserLocation { userLocation in
            LocationManager.shared.resolveLocationName(with: userLocation) { locationName in
                WeatherAPI.getWeatherForCurrentUserLocation(currentUserLocation: locationName!) { weatherForCurrentUserLocation in
                    print(weatherForCurrentUserLocation)
                }
            }
        }
    }
    
}

