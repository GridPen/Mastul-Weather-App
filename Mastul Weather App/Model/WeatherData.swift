//
//  WeatherData.swift
//  Mastul Weather App
//
//  Created by Debashish Mondal on 7/20/21.
//

import Foundation

struct WeatherData : Codable {
    
    let name: String
    let main : Main
    let weather: [Weather]
    let wind : Wind
    let clouds : Clouds
    let sys : Sys
    let timezone : Int
    
}


struct Main : Codable {
    let temp: Double
    let feels_like: Double
}

struct Weather : Codable {
    let id : Int
    let description: String
}

struct Wind : Codable {
    let speed : Double
    
}

struct Clouds : Codable {
    let all : Int
    
}

struct Sys : Codable {
    let country: String
    let sunrise: Int
    let sunset: Int
}
