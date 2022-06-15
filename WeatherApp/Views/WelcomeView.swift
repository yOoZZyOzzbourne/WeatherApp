//
//  WelcomeView.swift
//  WeatherApp
//
//  Created by Martin Ficek on 13.06.2022.
//

import SwiftUI
import CoreLocationUI

struct WelcomeView: View {
    // MARK: - Properties
    @EnvironmentObject var locationManager: LocationManager
    @Binding var Mode : Bool
    
    // MARK: - Body
    var body: some View {
        ZStack{
            
            BackgroundView(Mode: $Mode)
            VStack {
                
                Text("Weather App")
                    .bold().font(.title)
                
                Text("Please share your current location to get the weather in your area")
                    .padding()
                
                LocationButton(.shareCurrentLocation) {
                    locationManager.requestLocation()
                }
                .cornerRadius(30)
                .symbolVariant(.fill)
                .foregroundColor(.white)
            } // VStack
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .multilineTextAlignment(.center)
            .padding()
            }
            } // VStack
            
            
           
    }


//// MARK: - Preview
//struct WelcomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        WelcomeView()
//    }
//}
