//
//  OneLocation.swift
//  weatherfun
//
//  Created by Justin Bengtson on 9/6/21.
//

import Foundation

struct Weather: Codable {
    var coordinates: Coordinates?
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
}

struct Coordinates: Codable {
    var longitude: Float
    var latitude: Float
}

struct WeatherDescription: Codable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}

struct Main: Codable {
    var temp: Float
    var feelsLike: Float?
    var minTemp: Float?
    var maxTemp: Float?
    var pressure: Int
    var humidity: Int
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


