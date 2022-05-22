//
//  Weather.swift
//  WeatherApp
//
//  Created by user214203 on 5/20/22.
//

import Foundation
import SwiftUI

struct Weather: Decodable {
    let id: Int
    let description: String
}

struct Main: Decodable {
    let temp: Double
    let pressure: Int
    let humidity: Int
    let feels_like: Double
}

struct Wind: Decodable {
    let speed: Double
    let deg: Int
}

struct Clouds: Decodable {
    let all: Int
}

struct WeatherData: Decodable {
    let name: String
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let clouds: Clouds
}
