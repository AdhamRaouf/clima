    //
    //  ViewController.swift
    //  Clima
    //
    //  Created by Angela Yu on 01/09/2019.
    //  Copyright © 2019 App Brewery. All rights reserved.
    //

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextFild: UITextField!
    
    var weatherManeger = WeatherManeger()
    let locationManeger = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherManeger.delegate = self
        searchTextFild.delegate = self
        locationManeger.delegate = self
        locationManeger.requestWhenInUseAuthorization()
        locationManeger.requestLocation()
    }
        
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManeger.requestLocation()
    }
}

    //MARK: - CLLocationManagerDelegate

extension WeatherViewController : CLLocationManagerDelegate {
   
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let locationn = locations.first {
            locationManeger.stopUpdatingLocation()
            print("first Location data received.")
            print(locationn)
        }
        if let location = locations.last {
            locationManeger.stopUpdatingLocation()
            print("last Location data received.")
            print(location)
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManeger.fetchWeather(latitude : lat, longitude : lon)
            print("laaaaaaaaat : \(lat)")
            print("looooooooon : \(lon)")
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get users location.")
        print(error)
    }
}

    //MARK: - UITextFieldDelegate

extension WeatherViewController : UITextFieldDelegate {
    @IBAction func searchPressed(_ sender: Any) {
        searchTextFild.endEditing(true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextFild.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchTextFild.text != "" {
            return true
        } else {
            searchTextFild.placeholder = "Type anything ylaaaa"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextFild.text {
            weatherManeger.fetchWeather(cityName: city)
        }
        searchTextFild.text = ""
        searchTextFild.placeholder = "Search"
    }
}

    //MARK: - WeatherManegerDelegate

extension WeatherViewController : WeatherManegerDelegate {
    func didUpdateWeather(_ weatherManeher: WeatherManeger , weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperaturaString
            self.cityLabel.text = weather.cityNameString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

