//
//  WeatherModel.swift
//  Clima
//
//  Created by Artem Vaniukov on 07.09.2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionID: Int
    let cityName: String
    let temperature: Float
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        switch conditionID {
        case 200..<300:
            return "cloud.bolt.rain"
        case 300..<400:
            return "cloud.drizzle"
        case 500..<600:
            return "cloud.rain"
        case 600..<700:
            return "cloud.snow"
        case 711:
            return "smoke"
        case 721:
            return "sun.haze"
        case 731:
            return "sun.dust"
        case 741:
            return "cloud.fog"
        case 761:
            return "sun.dust"
        case 781:
            return "tornado"
        case 800:
            return "sun.max"
        case 801..<900:
            return "cloud"
        default:
            return "cloud.sun"
        }
    }
}
