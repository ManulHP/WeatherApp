//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by user214203 on 5/21/22.
//

import Foundation
import SwiftUI

struct WeatherModel {
    let id: Int
    let description: String
    let temp: Double
    let name: String
    let humidity: Int
    let pressure: Int
    let windSpeed: Double
    let direction: Int
    let cloudPercentage: Int
    let feelsLike: Double
    
    var temperature: String {
        return String(format: "%.1f", temp)
    }
    
    var feelLike: String {
        return String(format: "%.1f", feelsLike	)
    }
    
    var windSpeedInOneDP: String {
        return String(format: "%.1f", windSpeed)
    }
    
    var cloudImage: String {
        switch id {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "cloud.max"
        default:
            return "cloud"
        }
    }
    
    var detailData: [MoreInfo] {
        return [
            .init(title: "Temperature", icon: "thermometer", value: temperature, color: .red),
            .init(title: "Humidity", icon: "drop.fill", value: "\(humidity)", color: .blue),
            .init(title: "Pressure", icon: "digitalcrown.horizontal.press.fill", value: "\(pressure)", color: .green),
            .init(title: "Wind Speed", icon: "wind", value: "\(windSpeedInOneDP)", color: .orange),
            .init(title: "Wind Direction", icon: "arrow.up.left.circle", value:"\(direction)", color: .yellow),
            .init(title: "Clouds", icon: "icloud", value: "\(cloudPercentage)", color: .cyan),
            
        ]
    }
    
}

