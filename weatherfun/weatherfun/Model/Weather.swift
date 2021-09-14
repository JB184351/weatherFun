//
//  OneLocation.swift
//  weatherfun
//
//  Created by Justin Bengtson on 9/6/21.
//

import Foundation

struct Weather: Codable {
    var coordinates: Coordinates
    var weather: [WeatherDescription]
    var base: String
    var main: Main
    var visibility: Int
    var wind: Wind
    var clouds: Clouds
    var dt: Int
    var system: System?
    var timezone: Int
    var id: Int
    var name: String
    var cod: Int
    
    enum CodingKeys: String, CodingKey {
        case coordinates = "coord"
        case weather
        case base
        case main
        case visibility
        case wind
        case clouds
        case dt
        case system = "sys"
        case timezone
        case id
        case name
        case cod
    }
}

struct Coordinates: Codable {
    var longitude: Float
    var latitude: Float
    
    enum CodingKeys: String, CodingKey {
        case longitude = "lon"
        case latitude = "lat"
    }
}

struct WeatherDescription: Codable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}

struct Main: Codable {
    var temp: Float
    var feelsLike: Int?
    var minTemp: Float
    var maxTemp: Float
    var pressure: Int
    var humidity: Int
    
    enum Codingkeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case minTemp = "temp_min"
        case maxTemp = "temp_max"
        case pressure
        case humidity
    }
}

struct Wind: Codable {
    var speed: Float
    var deg: Int
}

struct Clouds: Codable {
    var all: Int
}

struct System: Codable {
    var type: Int
    var id: Int
    var country: String
    var sunrise: Int
    var susnet: Int
}


