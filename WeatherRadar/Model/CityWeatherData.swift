//
//  CityWeatherData.swift
//  WeatherRadar
//
//  Created by Nancy Jain on 18/09/22.
//

import Foundation
struct CityWeatherData: Decodable {
    enum CodingKeys: String, CodingKey {
        case time = "EpochTime"
        case weatherText = "WeatherText"
        case temperature = "Temperature"
    }
    
    let time: Double?
    let weatherText: String?
    let temperature: CityTemperature
    
}

struct CityTemperature: Decodable {
    enum CodingKeys: String, CodingKey {
        case metric = "Metric"
    }
    let metric: Celcius
}

struct Celcius: Decodable {
    enum CodingKeys: String, CodingKey {
        case value = "Value"
    }
    let value: Double
   
}
