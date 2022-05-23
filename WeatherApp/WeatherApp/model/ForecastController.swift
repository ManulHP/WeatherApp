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
    let baseURL: String = "https://api.openweathermap.org/data/2.5/onecall?appid=\(API.key)&exclude=hourly,minutely"
    
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
                var forcastDetailData = weatherData.daily.map{ daily in MoreForecast(
                    dt: daily.dt,
                    temp: daily.temp.day,
                    pressure: daily.pressure,
                    humidity: daily.humidity,
                    clouds: daily.clouds,
                    wind_speed: daily.wind_speed,
                    weather: daily.weather.first!)}
                
                self.forecast = ForecastModel(forecast: forcastDetailData)
            }
        }catch {
            print("error")
            print(error.localizedDescription)
        }
    }

}

