//
//  Forecast.swift
//  WeatherApp
//
//  Created by user214203 on 5/23/22.
//

import Foundation
import SwiftUI

struct ForecastData: Decodable {
    let current: Current
    let daily: [OCDaily]
    let hourly: [Hourly]
}

struct Current: Decodable {
    let dt: Int
    let temp: Double
    let pressure: Int
    let humidity: Int
    let clouds: Int
    let wind_speed: Double
    let weather: [Weather]
}

struct OCDaily: Decodable {
    let dt: Int
    let temp: Temperature
    let pressure: Int
    let humidity: Int
    let clouds: Int
    let wind_speed: Double
    let weather: [Weather]
}

struct Temperature: Decodable {
    let day: Double
}

struct Hourly: Decodable {
    let dt: Int
    let temp: Double
    let weather: [Weather]
}
