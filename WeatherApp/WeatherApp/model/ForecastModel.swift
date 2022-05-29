//
//  ForecastModel.swift
//  WeatherApp
//
//  Created by user214203 on 5/23/22.
//

import Foundation
import SwiftUI

struct ForecastModel {
    let forecast: [MoreForecast]
    let hourlyForecastData: [MoreHourly]
    let currentData: MoreHourly
}
