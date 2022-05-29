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
                    Label("Forecast", systemImage: "house")
                }
            IntervalScreen()
                .tabItem{
                    Label("Interval", systemImage: "house")
                }
        }
    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
