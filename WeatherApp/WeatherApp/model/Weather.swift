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
}

struct WeatherData: Decodable {
    let name: String
    let weather: [Weather]
    let main: Main
}
