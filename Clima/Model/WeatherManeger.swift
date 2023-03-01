    //
    //  WeatherManeger.swift
    //  Clima
    //
    //  Created by Adham Raouf on 10/02/2023.
    //  Copyright © 2023 App Brewery. All rights reserved.
    //

import Foundation
import CoreLocation



protocol WeatherManegerDelegate {
    func didUpdateWeather(_ weatherManeher: WeatherManeger, weather: WeatherModel)
    func didFailWithError(error: Error)
}
struct WeatherManeger {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=ff8fc8ac097f5644efd213a75a450774&units=metric"
    var delegate: WeatherManegerDelegate?
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString : String) {
            // create the URL
        if let url = URL(string: urlString) {
                // create a URLsession
            let session = URLSession(configuration: .default)
                // give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    print(error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
                // start the task
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let name = decodedData.name
            let temp = decodedData.main.temp
            let id = decodedData.weather[0].id
            let lat = decodedData.coord.lat
            let lon = decodedData.coord.lon
            let weather = WeatherModel(conditionId: id, cityName: name, temperatura: temp, lat: lat, lon: lon)
            
            print(weather.cityNameString)
            print(weather.temperaturaString)
            print(weather.conditionName)
            print(weather.latitudeString)
            print(weather.longitudeString)
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            print(error)
            return nil
        }
    }
}



