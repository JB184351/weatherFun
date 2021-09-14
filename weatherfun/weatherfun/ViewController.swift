//
//  ViewController.swift
//  weatherfun
//
//  Created by Justin Bengtson on 9/6/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        WeatherAPI.getWeatherForOneLocation { weatherForOneLocation in
            print(weatherForOneLocation)
        }
    }


}

