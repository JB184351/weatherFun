//
//  EndPoint.swift
//  weatherfun
//
//  Created by Justin Bengtson on 9/6/21.
//

import Foundation
import CoreLocation

enum EndPoint {
    case oneLocation
    case coordinates
}

struct WeatherURL {
    private let queryItems: [URLQueryItem]
    
    public var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.openweathermap.org"
        components.path = "/data/2.5/weather"
        components.queryItems = queryItems
        
        return components.url
    }
    
    // Gave the location parmater a default locattion name
    static func createURL(with endPoint: EndPoint, location: String? = "Las Vegas", coordinates: [String]?)  -> WeatherURL? {
        guard let privateKey = Bundle.main.infoDictionary?["API_KEY"] as? String else { return nil }
        
        var cleanedPrivateKey = privateKey
        
        cleanedPrivateKey.removeAll { char in
            char == "\""
        }
        
        var queryItems = [URLQueryItem]()
        
        switch endPoint {
        case .oneLocation:
            queryItems.append(URLQueryItem(name: "q", value: location))
        case .coordinates:
            queryItems = [URLQueryItem(name: "lat", value: coordinates!.first), URLQueryItem(name: "lon", value: coordinates!.last)]
        }
        
        let apiKeyQueryItem = URLQueryItem(name: "appid", value: cleanedPrivateKey)
        queryItems.append(apiKeyQueryItem)
        
        switch endPoint {
        case .oneLocation:
            return WeatherURL(queryItems: queryItems)
        case .coordinates:
            return WeatherURL(queryItems: queryItems)
        }
        
    }
    
}
