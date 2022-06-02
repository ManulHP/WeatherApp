//
//  SearchScreen.swift
//  WeatherApp
//
//  Created by user214203 on 5/20/22.
//

import Foundation
import SwiftUI

struct SearchScreen: View {
    
    @State private var textController = ""
    @StateObject var controller = WeatherController()

    @State private var weatherUnits: Units = .metric
    @State private var isAlertShowing: Bool = false
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            VStack {
                HStack{
                    TextField("Enter a city", text: $textController)
                        .textFieldStyle(.roundedBorder)
                    Button {
                        // action
                        Task {
                            let charset = CharacterSet(charactersIn:"1234567890.!@#$%^&*()<>/?{}[]|=+_~`")
                            if(textController.rangeOfCharacter(from: charset) != nil) {
                                isAlertShowing.toggle()
                            }else {
                                await controller.searchCity(cityName: self.textController, weatherUnit: self.weatherUnits)
                            }
                            
                        }
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .padding()
                    }
                    .alert(isPresented: $isAlertShowing) {
                        Alert(
                            title: Text("Warning!"),
                            message: Text("Please check the city name."),
                            dismissButton: .default(Text("Got it!"))
                        )
                    }
                }
                
                Picker("", selection: $weatherUnits) {
                    Text("Metric")
                        .tag(Units.metric)
                    Text("Imperial")
                        .tag(Units.imperial)
                }
                .pickerStyle(.segmented)
                .padding()
               
            
                if let data = controller.weather?.detailData {
                    List(data) {
                        item in HStack {
                            Image(systemName: item.icon)
                                .foregroundColor(item.color)
                            Text(item.title)
                                .font(.system(size: 16, weight: .regular, design: .rounded))
                               
                            Spacer()
                            if item.title == "Temperature" {
                                Text(self.weatherUnits == .metric ? "\(item.value)°C" : "\(item.value)°F")
                                    .font(.system(size: 20, weight: .regular, design: .rounded))
                            }else if (item.title == "Humidity"){
                                Text("\(item.value)%")
                                    .font(.system(size: 20, weight: .regular, design: .rounded))
                            }else if (item.title == "Pressure"){
                                Text("\(item.value) Pa")
                                    .font(.system(size: 20, weight: .regular, design: .rounded))
                            }else if (item.title == "Wind Speed"){
                                Text(self.weatherUnits == .metric ? "\(item.value)km/h" : "\(item.value)m/h")
                                    .font(.system(size: 20, weight: .regular, design: .rounded))
                            }else if (item.title == "Clouds"){
                                Text("\(item.value)%")
                                    .font(.system(size: 20, weight: .regular, design: .rounded))
                            } else {
                                Text("\(item.value)°")
                                .font(.system(size: 20, weight: .regular, design: .rounded))
                                
                            }
                                
                        }
                        .listRowSeparator(.hidden)
                        
                    }
                    
                    .listStyle(.plain)
                    .onChange(of: weatherUnits) {
                            _ in  Task{
                                await controller.searchCity(cityName: self.textController,weatherUnit: self.weatherUnits)
                        }
                    }
                   
                    
                } else {
                    Spacer()
                }
            } .padding()
        }
    }
}

struct SearchScreen_Previews: PreviewProvider {
    static var previews: some View {
        SearchScreen()
    }
}
