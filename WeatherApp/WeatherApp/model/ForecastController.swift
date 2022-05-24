//
//  ForecastController.swift
//  WeatherApp
//
//  Created by user214203 on 5/23/22.
//

import Foundation
import SwiftUI

class ForecastController: ObservableObject {
    /// Base URL
    let baseURL: String = "https://api.openweathermap.org/data/2.5/onecall?appid=\(API.key)&exclude=minutely"
    
    @Published var forecast: ForecastModel?
    private var weatherUnit: Units = .metric
    
    ///  calling the api
    func fetchForecastData(weatherUnit: Units) async {
        let lat = 6.053519
        let lon = 80.220978
        self.weatherUnit = weatherUnit
        
        let url = "\(baseURL)&lat=\(lat)&lon=\(lon)&units=\(weatherUnit.rawValue)"
        print(url)
        
        await requestForecastData(url: url)
    }
    
    func requestForecastData(url: String) async {
        guard let url = URL(string: url) else { return }
        
        do{
            let (data,_) = try await URLSession.shared.data(from: url)
            
            let weatherData = try JSONDecoder().decode(ForecastData.self, from: data)
            print("working")
            print(weatherData)
            
            DispatchQueue.main.async {
                let forcastDetailData = weatherData.daily.map { daily in MoreForecast(
                    dt: daily.dt.unixToDate()!,
                    temp: String(format: "%.1f", daily.temp.day),
                    pressure: daily.pressure,
                    humidity: daily.humidity,
                    clouds: daily.clouds,
                    wind_speed: String(format: "%.1f", daily.wind_speed),
                    weather: daily.weather.first!,
                    icons: getCloudIcon(id: daily.weather.first?.id ?? 0)
                )}
                
                
                var hourData = weatherData.hourly.map {hourly in MoreHourly(dt: hourly.dt.unixToDate()!,
                                                                            temp: "\(hourly.temp)",
                                                                            weather: hourly.weather.first!,
                                                                            icons: getCloudIcon(id: hourly.weather.first?.id ?? 0),
                                                                            hour: hourly.dt.unixToDate()!.get(.hour)
                )}
                
                hourData = hourData.filter({ items in
                    return items.hour % 3 == 0
                })
                
                self.forecast = ForecastModel(forecast: forcastDetailData, hourlyForecastData: hourData)
                
            }
            print("sadas ",weatherData)
        }catch {
            print("error")
            print(error.localizedDescription)
        }
    }

}

