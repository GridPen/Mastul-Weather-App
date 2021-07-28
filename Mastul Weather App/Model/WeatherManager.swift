//
//  WeatherManager.swift
//  Mastul Weather App
//
//  Created by Debashish Mondal on 7/20/21.
//


import Foundation
import CoreLocation


protocol WeatherManagerDelegate {
    func didUpdateWeather(_ WeatherManager:WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=3d823c16fca8f30d1ca38eb1b7a4b71b&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        self.performRequest(with: urlString)
        
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
         
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        
        if let url = URL(string: urlString){
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    //                    let dataString = String(data: safeData, encoding: .utf8)
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                        
                    }
                    
                }
                
            }
            
            task.resume()
        }
        
    }
    func parseJSON(_ weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        
        do{
            let decodeData =  try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodeData.weather[0].id
            let temp = decodeData.main.temp
            let name = decodeData.name
            let feelsLike = decodeData.main.feels_like
            let details = decodeData.weather[0].description
            
            
            let weather = WeatherModel(conditionID: id, cityName: name, temperature: temp, feels: feelsLike, details: details)
            
            
            print(weather.conditionName)
            print(weather.cityName)
            print(weather.temperatureString)
            print(weather.feelsLikeString)
            print(weather.details)
            
            return weather

        }
        catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    

    
}
