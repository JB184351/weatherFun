//
//  OneLocation.swift
//  weatherfun
//
//  Created by Justin Bengtson on 9/6/21.
//

import Foundation

struct Weather: Codable {
    let coordinates: Coordinates
    let weather: [WeatherElement]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let system: System
    let timezone, id: Int
    let name: String
    let cod: Int
    
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

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
}

// MARK: - Coord
struct Coordinates: Codable {
    let lon: Double
    let lat: Double
}

// MARK: - Main
struct Main: Codable {
    let temp: Double
    let feelsLike: Double
    let tempMin:Double
    let tempMax: Double
    let pressure: Int
    let humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case humidity
    }
}

// MARK: - Sys
struct System: Codable {
    let type: Int
    let id: Int
    let country: String
    let sunrise: Int
    let sunset: Int
}

// MARK: - WeatherElement
struct WeatherElement: Codable {
    let id: Int
    let main: String
    let weatherDescription: String
    let icon: String

    enum CodingKeys: String, CodingKey {
        case id
        case main
        case weatherDescription = "description"
        case icon
    }
}

struct Wind: Codable {
    let speed: Double
    let deg: Int
}
