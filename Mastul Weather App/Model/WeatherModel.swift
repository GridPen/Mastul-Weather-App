//
//  WeatherModel.swift
//  Mastul Weather App
//
//  Created by Debashish Mondal on 7/20/21.
//


import Foundation


struct WeatherModel {
    let conditionID: Int
    let cityName : String
    let temperature : Double
    let feels : Double
    let details: String
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var feelsLikeString: String{
        return String(format: "%.1f", feels)
    }
    
    
    
    var conditionName:String{
        switch conditionID {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    
    
    
    
}
