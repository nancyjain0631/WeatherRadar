//
//  WeatherData.swift
//  WeatherRadar
//
//  Created by Nancy Jain on 18/09/22.
//

import Foundation

struct WeatherData: Decodable {
    enum CodingKeys: String, CodingKey {
        case key = "Key"
        case name = "LocalizedName"
        case country = "Country"
    }
    
    let key: String?
    let name: String?
    let country: CountryCode
}

struct CountryCode: Decodable {
    enum CodingKeys: String, CodingKey {
        case countryId = "ID"
    }
    let countryId: String?

    
}
