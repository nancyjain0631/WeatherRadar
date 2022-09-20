//
//  WeatherManager.swift
//  WeatherRadar
//
//  Created by Nancy Jain on 18/09/22.
//

import Foundation

struct WeatherManager {
    let weatherURL = "https://dataservice.accuweather.com/locations/v1/cities/autocomplete?"
    
    let cityDetailsURL = "https://dataservice.accuweather.com/currentconditions/v1/"
    let apiKey = "apikey=HRy8hDoKD0KvrYWgNRsT9KgEknnPAPSJ"
    
    func performRequest(text: String, completionHandler: @escaping ([WeatherData]) -> Void) {
        
        let urlString = "\(weatherURL)\(apiKey)&q=\(text.lowercased())"
        let url = URL(string: urlString)
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([WeatherData].self, from: data)
                completionHandler(jsonData)
//                print(jsonData.map{ $0.Key })
                
//                print(jsonData.first?.Key)
//                print(jsonData.first?.Country.ID)
            } catch {
                let error = error
                print(error)
            }
        }
        task.resume()
    }
    func fetchCityData(cityKey: String, completionHandler: @escaping ([CityWeatherData]) -> Void) {
        let urlString = "\(cityDetailsURL)\(cityKey)?\(apiKey)"
        let url = URL(string: urlString)
        print(urlString)
        
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([CityWeatherData].self, from: data)
                completionHandler(jsonData)
//                print("jsonData \(jsonData)")
//                print(jsonData.map{ $0.Key })
                
//                print(jsonData.first?.WeatherText!)
//                print(jsonData.first?.Country.ID)
            } catch {
                let error = error
                print(error)
            }
        }
        task.resume()
    }
    
}
