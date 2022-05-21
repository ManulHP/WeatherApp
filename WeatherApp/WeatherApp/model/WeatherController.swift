//
//  WeatherController.swift
//  WeatherApp
//
//  Created by user214203 on 5/20/22.
//

import Foundation

class WeatherController: ObservableObject {
    /// Base URL	
    let baseURL: String = "https://api.openweathermap.org/data/2.5/weather?appid=\(API.key)"
    
    @Published var weather: WeatherModel?
    
    ///  calling the api
    func fetchWeatherData() async {
        let lat = 6.053519
        let lon = 80.220978
        
        let url = "\(baseURL)&lat=\(lat)&lon=\(lon)&units=metric"
        print(url)
        
        guard let url = URL(string: url) else { return }
        
        do{
            let (data,_) = try await URLSession.shared.data(from: url)
            
            let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
            print(weatherData)
            
            DispatchQueue.main.async {
//                self.weather = weatherData
                self.weather = WeatherModel(id: weatherData.weather.first?.id ?? 0, description: weatherData.weather.first?.description ?? "", temp: weatherData.main.temp, name: weatherData.name)
            }
        }catch {
            print(1)
            print(error.localizedDescription)
        }
    }
}