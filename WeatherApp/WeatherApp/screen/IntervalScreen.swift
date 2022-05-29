//
//  SearchScreen.swift
//  WeatherApp
//
//  Created by user214203 on 5/20/22.
//

import Foundation
import SwiftUI

struct IntervalScreen: View {
    
    @State private var weatherUnits: Units = .metric
    @StateObject private var manager = ForecastController()
    
    var body: some View {
        VStack {
            if let weather = manager.forecast {
                if let current = weather.currentData {
                    Text("\(current.dt)")
                        .font(.system(size: 18, weight: .light, design: .rounded))
                    HStack {
                        Image(systemName: current.icons)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                        Text("\(current.temp)°C")
                            .font(.system(size: 60, weight: .heavy, design: .rounded))
                            .foregroundColor(.yellow)
                    }
                    Text("\(current.weather.description)")
                        .font(.system(size: 18, weight: .black, design: .rounded))
                }
                List (weather.hourlyForecastData) { item in
                    HStack (alignment: .center) {
                        Image(systemName: item.icons)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                            .foregroundColor(.cyan)
                        Spacer()
                            .frame(width: 10)
                        VStack (alignment: .leading){
                            Text("\(item.weather.description)")
                            Text(item.dt)
                        }
                        Spacer()
                        Text("\(item.temp)°C")
                        
                    
                        
                    }
                    .padding()
                }
                .listStyle(PlainListStyle())
            }else {
                Spacer()
            }
            
            
        }
        .onAppear {
            Task {
                await manager.fetchForecastData(weatherUnit: self.weatherUnits)
            }
        }
        .padding(.top, 25)
    }
}

struct IntervalScreen_Previews: PreviewProvider {
    static var previews: some View {
        IntervalScreen()
    }
}
