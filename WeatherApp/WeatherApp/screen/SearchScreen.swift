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
    
    var body: some View {
        VStack {
            HStack{
                TextField("Enter a city", text: $textController)
                    .textFieldStyle(.roundedBorder)
                
                Button {
                    // action
                    Task {
                        await controller.searchCity(cityName: self.textController)
                    }
                } label: {
                    Image(systemName: "magnifyingglass")
                        .padding()
                }
            }
            
            if let data = controller.weather?.detailData {
                List(data) {
                    item in HStack {
                        Image(systemName: item.icon)
                        Text(item.title)
                            .font(.system(size: 16, weight: .regular, design: .rounded))
                        Spacer()
                        Text("\(item.value)")
                            .font(.system(size: 20, weight: .regular, design: .rounded))
                    }
                }
            } else {
                Spacer()
            }
        } .padding()
    }
}

struct SearchScreen_Previews: PreviewProvider {
    static var previews: some View {
        SearchScreen()
    }
}
