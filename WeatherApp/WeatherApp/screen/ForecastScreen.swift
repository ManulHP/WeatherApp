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
                            HStack (alignment: .center) {
                                VStack {
                                    Image(systemName: item.icons)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 25, height: 25)
                                        .foregroundColor(.cyan)
                                    Text(item.weather.description)
                                    Text("\(item.clouds)%")
                                }
                                Spacer()
                                VStack {
                                    Image(systemName: "thermometer")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 25, height: 25)
                                        .foregroundColor(.red)
                                    Text(item.temp)
                                }
                                Spacer()
                                VStack {
                                    Image(systemName: "wind")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 25, height: 25)
                                        .foregroundColor(.orange)
                                    Text(item.wind_speed)
                                }
                                Spacer()
                                VStack {
                                    Image(systemName: "drop.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 25, height: 25)
                                        .foregroundColor(.blue)
                                    Text("\(item.humidity)")
                                }
                                
                            }.padding()
                        }
                    }
                    .listStyle(PlainListStyle())
                    .onChange(of: weatherUnits) {
                            _ in  Task{
                            await manager.fetchForecastData(weatherUnit: self.weatherUnits)
                        }
                    }
                }else {
                    Spacer()
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

