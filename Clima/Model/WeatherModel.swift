    //
    //  WeatherModel.swift
    //  Clima
    //
    //  Created by Adham Raouf on 10/02/2023.
    //  Copyright © 2023 App Brewery. All rights reserved.
    //

import Foundation
import CoreLocation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperatura: Double
    let lat: CLLocationDegrees
    let lon: CLLocationDegrees

    
    var latitudeString : String {
        return String(lat)
    }
    
    var longitudeString : String {
        return String(lon)
    }
    
    
    var cityNameString : String {
        return cityName
    }
    
    var conditionName: String {
        switch conditionId {
            case 200...232:
                return "cloud.bolt.rain"
            case 300...321:
                return "cloud.drizzle"
            case 500...531:
                return "cloud.rain"
            case 600...622:
                return "cloud.snow"
            case 701...781:
                return "cloud.fog"
            case 800:
                return "sun.max"
            case 801...804:
                return "cloud.bolt"
            default:
                return "xmark.circle.fill"
        }
    }
    
    var temperaturaString : String {
        return String(format: "%.1f", temperatura)
    }
}








