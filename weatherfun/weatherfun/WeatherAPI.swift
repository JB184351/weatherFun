//
//  WeatherAPI.swift
//  weatherfun
//
//  Created by Justin Bengtson on 9/8/21.
//

import Foundation
import CoreLocation

class WeatherAPI {
    
    public static func getWeatherForCurrentUserLocation(completionBlock: @escaping (WeatherProtocol) -> (Void)) {
        LocationManager.shared.getUserLocation { location in
            if let locationName = location?.locality {
                load(with: .oneLocation, and: .createURL(with: .oneLocation, location: (locationName), coordinates: nil)!) { weatherForCurrentUserLocation in
                    completionBlock(weatherForCurrentUserLocation)
                }
            }
        }
    }
    
    public static func getWeatherForCurrentUerLocationWithCoordinates(completionBlock: @escaping (WeatherProtocol) -> (Void)) {
        LocationManager.shared.getUserLocation { location in
            let latitudeText = String(format: "%f", location?.location?.coordinate.latitude as! CVarArg)
            let longitudeText = String(format: "%f", location?.location?.coordinate.longitude as! CVarArg)
            
            load(with: .coordinates, and: .createURL(with: .coordinates, coordinates: [latitudeText, longitudeText])!) { weatherForoCurrentUserLocation in
                completionBlock(weatherForoCurrentUserLocation)
            }
        }
    }
    
    private static func load(with endPoint: EndPoint, and endPointURL: WeatherURL, completionBlock: @escaping (WeatherProtocol) -> (Void)) {
        if let url = endPointURL.url {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    let jsonDecoder = JSONDecoder()
                    do {
                        switch endPoint {
                        case .oneLocation:
                            let parsedJSON = try jsonDecoder.decode(Weather.self, from: data)
                            completionBlock(parsedJSON)
                        case .coordinates:
                            let parsedJSON = try jsonDecoder.decode(Weather.self, from: data)
                            completionBlock(parsedJSON)
                        case .daily:
                            let parsedJSON = try jsonDecoder.decode(WeatherForecast.self, from: data)
                            completionBlock(parsedJSON)
                        }
                    } catch {
                        print(error)
                    }
                }
            }.resume()
        }
    }
}
