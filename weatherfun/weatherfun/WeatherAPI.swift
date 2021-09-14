//
//  WeatherAPI.swift
//  weatherfun
//
//  Created by Justin Bengtson on 9/8/21.
//

import Foundation

class WeatherAPI {
    
    public static func getWeatherForOneLocation(completionBlock: @escaping (Weather) -> (Void)) {
        load(with: .oneLocation, and: .createURL(with: .oneLocation)!) { weatherForOneLocaation in
            completionBlock(weatherForOneLocaation)
        }
    }
    
    private static func load(with endPoint: EndPoint, and endPointURL: WeatherURL, completionBlock: @escaping (Weather) -> (Void)) {
        if let url = endPointURL.url {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    let jsonDecoder = JSONDecoder()
                    do {
                        switch endPoint {
                        case .oneLocation:
                            let parsedJSON = try jsonDecoder.decode(Weather.self, from: data)
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
