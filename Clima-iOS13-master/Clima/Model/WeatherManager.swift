//
//  WeatherManager.swift
//  Clima
//
//  Created by Artem Vaniukov on 06.09.2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    
    let units = "metric"
    let openWeatherAPIKey = "212e2732b3f4a7204d1a8a34273f564a"
    var weatherURL: String {
        return "https://api.openweathermap.org/data/2.5/weather?appid=\(openWeatherAPIKey)&units=\(units)"
    }
    
    var delegate: WeatherManagerDelegate?
    
    
    func fetchWeather(for city: String) {
        let urlString = "\(weatherURL)&q=\(city)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                self.delegate?.didFailWithError(error: error)
                return
            }
            if let data = data {
                if let weather = self.parseJSON(weatherData: data) {
                    self.delegate?.didUpdateWeather(weather)
                }
            }
        }
        task.resume()
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            
            let conditionId = decodedData.weather[0].id
            let cityName = decodedData.name
            let temperature = decodedData.main.temp
            
            let weather = WeatherModel(conditionID: conditionId, cityName: cityName, temperature: temperature)
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
