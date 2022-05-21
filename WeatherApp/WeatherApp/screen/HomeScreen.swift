//
//  HomeScreen.swift
//  WeatherApp
//
//  Created by user214203 on 5/20/22.
//

import Foundation
import SwiftUI

struct HomeScreen: View {
    
    @StateObject var controller = WeatherController()
    
    var body: some View {
        ZStack{
            Color.black
                .ignoresSafeArea()
            VStack{
                Text(controller.weather?.name ?? "--")
                    .font(.system(size: 30, weight: .medium, design: .rounded))
                Text(controller.weather?.description ?? "--")
                    .font(.system(size: 26, weight: .black, design: .rounded))
                Image(systemName: controller.weather?.cloudImage ?? "cloud")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                Text("\(controller.weather?.temp ?? 0)")
                    .font(.system(size: 60, weight: .heavy, design: .rounded))
                    .foregroundColor(.yellow)
                    
            }
            .foregroundColor(.white)
            
        }
        .onAppear{
            Task {
                await controller.fetchWeatherData()
            }
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
