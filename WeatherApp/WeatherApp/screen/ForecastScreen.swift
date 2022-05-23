//
//  ForecastScreen.swift
//  WeatherApp
//
//  Created by user214203 on 5/23/22.
//

import Foundation
import SwiftUI

struct ForecastScreen: View {
    
    @State private var weatherUnits: Units = .metric
    @StateObject private var manager = ForecastController()
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("", selection: $weatherUnits) {
                    Text("Metric")
                        .tag(Units.metric)
                    Text("Imperial")
                        .tag(Units.imperial)
                }
                .pickerStyle(.segmented)
                .padding()
                if let data = manager.forecast?.forecast {
                    List (0..<6) { index in
                        let item = data[index]
                        Section("\(item.dt)") {
                            HStack(spacing: 20) {
                                Image(systemName: "icloud")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(.cyan)
                                VStack (alignment: .leading) {
                                    Text("\(item.weather.description)")
                                    Text("\(item.temp)")
                                    HStack {
                                        Image(systemName: "cloud.fill")
                                            .foregroundColor(.gray)
                                        Text("\(00)%")
                                        Image(systemName: "drop")
                                            .foregroundColor(.blue)
                                        Text("\(item.wind_speed)")
                                    }
                                    Text("Humidity: \(00)%")
                                }
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                    .onChange(of: weatherUnits ){_ in
                        Task{
                            await manager.fetchForecastData(weatherUnit: self.weatherUnits)
                        }
                    }
                }
                
                
            }
            .navigationTitle("Forecast Weather")
            .onAppear {
                Task {
                    await manager.fetchForecastData(weatherUnit: self.weatherUnits)
                }
            }
        }
    }
}

struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastScreen()
    }
}

