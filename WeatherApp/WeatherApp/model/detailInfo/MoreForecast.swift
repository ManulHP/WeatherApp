//
//  MoreForecast.swift
//  WeatherApp
//
//  Created by user214203 on 5/23/22.
//

import Foundation
import SwiftUI

struct MoreForecast: Identifiable {
    let id = UUID()
    let dt: String
    let temp: String
    let pressure: Int
    let humidity: Int
    let clouds: Int
    let wind_speed: String
    let weather: Weather
}
