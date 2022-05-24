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
                Text("\(controller.weather?.temperature ?? "--")°C")
                    .font(.system(size: 60, weight: .heavy, design: .rounded))
                    .foregroundColor(.yellow)
                
                Text("Feels like")
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundColor(.white)
                
                Text("\(controller.weather?.feelLike ?? "--")°C")
                    .font(.system(size: 40, weight: .heavy, design: .rounded))
                    .foregroundColor(.yellow)
                
                Spacer()
                    .frame(height: 50)
                
                
                
                HStack {
                    VStack {
                        Image(systemName: "drop.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                            .foregroundColor(.blue)
                        Text("\(controller.weather?.humidity ?? 0)%")
                            .font(.system(size: 22, weight: .semibold, design: .rounded))
                            .foregroundColor(.white)
                    }
                    Spacer()
                        .frame(width: 50)
                    VStack {
                        Image(systemName: "wind")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                            .foregroundColor(.orange)
                        Text("\(controller.weather?.windSpeedInOneDP ?? "0")km/h")
                            .font(.system(size: 22, weight: .semibold, design: .rounded))
                            .foregroundColor(.white)
                    }
                
                }.padding([.horizontal], 50)
                    
                    
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
