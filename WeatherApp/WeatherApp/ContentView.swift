//
//  ContentView.swift
//  WeatherApp
//
//  Created by user214203 on 5/20/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeScreen()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            SearchScreen()
                .tabItem {
                    Label("Current", systemImage: "magnifyingglass")
                }
            ForecastScreen()
                .tabItem{
                    Label("Forecast", systemImage: "goforward")
                }
            IntervalScreen()
                .tabItem{
                    Label("Interval", systemImage: "deskclock")
                }
        }
    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
