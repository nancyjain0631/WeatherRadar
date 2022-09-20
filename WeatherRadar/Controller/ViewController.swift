//
//  ViewController.swift
//  WeatherRadar
//
//  Created by Nancy Jain on 18/09/22.
//

import UIKit

class ViewController: UIViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var weatherManager = WeatherManager()
    var weatherData = [WeatherData]()
    var cityWeatherData = [CityWeatherData]()
    var myIndex: Int = 0
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(self.tableView)
        title = "Search City"
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Type City Name"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        searchController.searchBar.delegate = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      
      if let indexPath = tableView.indexPathForSelectedRow {
        tableView.deselectRow(at: indexPath, animated: true)
      }
    }
    

        
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    func updateSearchResults(for searchController: UISearchController) {
//        unwrapping optional since text is an optional value
        guard let text = searchController.searchBar.text else {
            return
        }
        if(!isSearchBarEmpty) {
            weatherManager.performRequest(text: text) { [weak self] weatherData in
                self?.weatherData = weatherData
                DispatchQueue.main.async{
                    self?.tableView.reloadData()
                }
                
            }
        }
        }
    
}
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let weatherData: WeatherData
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        weatherData = self.weatherData[indexPath.row]
        cell?.textLabel?.text = "\(weatherData.name!), \(weatherData.country.countryId!)"
//        let cityKey = weatherData.Key!
//        print(cityKey)
        return cell!
    }
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        instantiate st
        
        
        let weatherData: WeatherData
        let cityWeatherData: CityWeatherData
        self.myIndex = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
        
        weatherData = self.weatherData[indexPath.row]
        let cityKey = weatherData.key!
        let cityName = weatherData.name!
        weatherManager.fetchCityData(cityKey: cityKey) { [weak self] cityWeatherData in
            self?.cityWeatherData = cityWeatherData
            DispatchQueue.main.async{
                self?.tableView.reloadData()
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let detailViewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
                detailViewController.cityWeatherData = cityWeatherData.first
                detailViewController.weatherData = weatherData
                self?.navigationController?.pushViewController(detailViewController, animated: true)
            }
        }
    }
    
    
}

