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
        
        WeatherAPI.getWeatherForCurrentUserLocation { weatherForCurrentLocation in
            print(weatherForCurrentLocation)
        }
    }
    
}

