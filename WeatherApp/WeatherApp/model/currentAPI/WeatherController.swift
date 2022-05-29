//
//  WeatherController.swift
//  WeatherApp
//
//  Created by user214203 on 5/20/22.
//

import Foundation
import SwiftUI

enum Units: String {
    case metric = "metric"
    case imperial = "imperial"
}

class WeatherController: ObservableObject {
    /// Base URL	
    let baseURL: String = "https://api.openweathermap.org/data/2.5/weather?appid=\(API.key)"
    
    @Published var weather: WeatherModel?
    private var weatherUnit: Units = .metric
    
    ///  calling the api
    func fetchWeatherData() async {
        let lat = 6.053519
        let lon = 80.220978
        
        let url = "\(baseURL)&lat=\(lat)&lon=\(lon)&units=metric"
        print(url)
        
        await requestWeatherData(url: url)
    }
    
    func requestWeatherData(url: String) async {
        guard let url = URL(string: url) else { return }
        
        do{
            let (data, code) = try await URLSession.shared.data(from: url)
            
            let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
            print(weatherData)
            if let response = code as? HTTPURLResponse  {
                print("asdasd: ", response.statusCode)
                if(response.statusCode == 200){
                    DispatchQueue.main.async {
        //                self.weather = weatherData
        //                self.weather = WeatherModel(id: weatherData.weather.first?.id ?? 0, description: weatherData.weather.first?.description ?? "", temp: weatherData.main.temp, name: weatherData.name)
                        self.weather = WeatherModel(id: weatherData.weather.first?.id ?? 0,
                                                    description: weatherData.weather.first?.description ?? "",
                                                    temp: self.weatherUnit == .metric ? weatherData.main.temp : weatherData.main.temp,
                                                    name: weatherData.name,
                                                    humidity: weatherData.main.humidity,
                                                    pressure: weatherData.main.pressure,
                                                    windSpeed: weatherData.wind.speed,
                                                    direction: weatherData.wind.deg,
                                                    cloudPercentage: weatherData.clouds.all,
                                                    feelsLike: weatherData.main.feels_like)
                    }
                } 
            }
            
            
        }catch {
            print(1)
            print(error.localizedDescription)
        }
    }
    
    func searchCity(cityName: String, weatherUnit: Units) async {
        self.weatherUnit = weatherUnit
        let url = "\(baseURL)&q=\(cityName)&units=\(weatherUnit)"
        
        await requestWeatherData(url: url)
    }
    
}
