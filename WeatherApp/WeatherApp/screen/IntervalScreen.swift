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
            Text("\(Date())")
            HStack {
                Image(systemName: "cloud")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                Text("144°C")
                    .font(.system(size: 60, weight: .heavy, design: .rounded))
                    .foregroundColor(.yellow)
            }
            Text("Dizzy")
                .font(.system(size: 18, weight: .black, design: .rounded))
            
            if let data = manager.forecast?.hourlyForecastData {
                List (data) { item in
                    HStack (alignment: .center) {
                        Image(systemName: item.icons)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                            .foregroundColor(.cyan)
                        
                        VStack {
                            Text("\(item.weather.description)")
                            Text(item.dt)
                        }
                        Spacer()
                        Text("\(item.temp)")
                        
                    
                        
                    }
                    .padding()
                }
                .listStyle(PlainListStyle())
            } else {
                Spacer()
            }
        }
        .onAppear {
            Task {
                await manager.fetchForecastData(weatherUnit: self.weatherUnits)
            }
        }
    }
}

struct IntervalScreen_Previews: PreviewProvider {
    static var previews: some View {
        IntervalScreen()
    }
}
