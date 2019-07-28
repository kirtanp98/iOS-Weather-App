//
//  WeatherModel.swift
//  Weather App
//
//  Created by Kirtan Patel on 7/27/19.
//  Copyright © 2019 Kirtan Patel. All rights reserved.
//

import Foundation

class WeatherModel : Codable {
    let latitude : Double
    let longitude: Double
    let currentWeather : currentWeatherModel
    
    class currentWeatherModel : Codable {
        let time : Double
        let summary : String
        let icon : String
        let precipProbability : Double
        let precipitaionType : String?
        let temperature : Double

        enum CodingKeys: String, CodingKey {
            case time
            case summary
            case icon
            case precipProbability
            case precipitaionType = "precipType"
            case temperature
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
        case currentWeather = "currently"
    }
    
}


