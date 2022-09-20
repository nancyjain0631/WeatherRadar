//
//  DetailViewController.swift
//  WeatherRadar
//
//  Created by Nancy Jain on 20/09/22.
//


import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var weatherConditionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    var weatherManager = WeatherManager()
//    var cityWeatherData = [CityWeatherData]()
//    var weatherData = [WeatherData]()
    var weatherData: WeatherData? {
        didSet {
            configureView()
        }
    }
    var cityWeatherData: CityWeatherData? {
      didSet {
        configureView()
      }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
//        print(cityWeatherData.)
//        self.temperatureLabel.text = cityWeatherData.first?.WeatherText
//        print(weatherData.first?.LocalizedName)
        
    }
    func configureView() {
        if let cityData = cityWeatherData,
           let timeLabel = timeLabel,
           let weatherImageView = weatherImageView,
           let cityLabel = cityLabel,
           let weatherConditionLabel = weatherConditionLabel,
           let temperature = temperatureLabel {

            weatherConditionLabel.text = cityWeatherData?.weatherText
            temperature.text = String(cityWeatherData?.temperature.metric.value ?? 0)
            cityLabel.text = weatherData?.name
            timeLabel.text = String(cityWeatherData?.time ?? 0)
            
            let date = NSDate(timeIntervalSince1970: 1663670880 )
            var currentDate = Date()
             
            let timezoneOffset =  TimeZone.current.secondsFromGMT()
             
            // 2) Get the current date (GMT) in seconds since 1970. Epoch datetime.
            let epochDate = cityWeatherData?.time ?? 0
             
            // 3) Perform a calculation with timezoneOffset + epochDate to get the total seconds for the
            //    local date since 1970.
            //    This may look a bit strange, but since timezoneOffset is given as -18000.0, adding epochDate and timezoneOffset
            //    calculates correctly.
            let timezoneEpochOffset = (epochDate + Double(timezoneOffset))
             
            // 4) Finally, create a date using the seconds offset since 1970 for the local date.
            let timeZoneOffsetDate = Date(timeIntervalSince1970: timezoneEpochOffset)
            print(timeZoneOffsetDate)
            
            print("hello")
        }
    }
    
}
