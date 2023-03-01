//
//  WeatherData.swift
//  Clima
//
//  Created by Adham Raouf on 10/02/2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let coord : Coord
    
    
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
//    let description: String
    let id : Int
}

struct Coord: Codable {
    let lat: Double
    let lon: Double
}
