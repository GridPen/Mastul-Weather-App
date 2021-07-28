//
//  MastulViewController.swift
//  Mastul Weather App
//
//  Created by Debashish Mondal on 7/20/21.
//

import UIKit
import CoreLocation

class MastulViewController: UIViewController {

    
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var cityText: UILabel!
    @IBOutlet weak var conditionText: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsTemperatureLabel: UILabel!
    @IBOutlet weak var conditionImage: UIImageView!
    
    
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        
        weatherManager.delegate = self
        
        searchText.delegate = self
    }
    @IBAction func locationButtonPressed(_ sender: UIButton) {
    
        locationManager.requestLocation()
    }
    

    
}


//MARK: - UITextFieldDelegate

extension MastulViewController: UITextFieldDelegate {
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchText.endEditing(true)
        print(searchText.text!)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchText.endEditing(true)
        print(searchText.text!)
        return true
        
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type Something"
            return false
        }
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {

        if let city = searchText.text {
            weatherManager.fetchWeather(cityName: city)
        }


        searchText.text = ""

    }
    
    
    
}


//MARK: -  WeatherManagerDelegate


extension MastulViewController : WeatherManagerDelegate {
    
    func didUpdateWeather(_ WeatherManager:WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImage.image = UIImage(systemName:weather.conditionName)
            self.cityText.text = weather.cityName
            
        }
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
}


//MARK: -   CLLocationManagerDelegate


extension MastulViewController :  CLLocationManagerDelegate  {
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}


