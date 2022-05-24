//
//  SplashScreen.swift
//  WeatherApp
//
//  Created by user214203 on 5/24/22.
//

import SwiftUI

struct SplashScreen: View {
    
    @State private var isActive = false
    @State private var opacity = 0.5
    @State private var size = 0.7
    
    var body: some View {
        
        if isActive {
            ContentView()
        } else {
            ZStack {
                Color.black
                    .ignoresSafeArea()

                VStack {
                    VStack {
                        Image("logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                        Text("Weather App")
                            .font(.system(size: 60, weight: .heavy, design: .rounded))
                            .foregroundColor(.white)
                    }
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear{
                        withAnimation(.easeIn(duration: 8.0)) {
                            self.opacity = 1.0
                            self.size = 0.9
                        }
                    }
                }
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        withAnimation {
                            self.isActive = true
                        }
                    }
                }
            }
        }
        
        
        
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
