//
//  EndPoint.swift
//  weatherfun
//
//  Created by Justin Bengtson on 9/6/21.
//

import Foundation

enum EndPoint {
    case oneLocation
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
    
   static func createURL(with endPoint: EndPoint)  -> WeatherURL? {
        guard let privateKey = Bundle.main.infoDictionary?["API_KEY"] as? String else { return nil }
        
        var cleanedPrivateKey = privateKey
        
        cleanedPrivateKey.removeAll { char in
            char == "\""
        }
        
        let apiKeyQueryItem = URLQueryItem(name: "appid", value: cleanedPrivateKey)
        
        switch endPoint {
        case .oneLocation:
            return WeatherURL(queryItems: [URLQueryItem(name: "q", value: "Las Vegas"), apiKeyQueryItem])
        }
    }
    
}
