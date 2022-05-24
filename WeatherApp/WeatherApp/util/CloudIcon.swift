//
//  CloudIcon.swift
//  WeatherApp
//
//  Created by user214203 on 5/24/22.
//

import Foundation
import SwiftUI

func getCloudIcon(id: Int) -> String {
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
