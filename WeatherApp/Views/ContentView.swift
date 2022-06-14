//
//  ContentView.swift
//  WeatherApp
//
//  Created by Martin Ficek on 10.06.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager(apiClient: APIClient())
    @State var weather: CurrentWeather?
    @State var forecast: ForecastWeather?
   
    var body: some View {
        ZStack{

            BackgroundView()
            
            VStack(spacing: 15) {
               
                if let location = locationManager.location {
                if let weather = weather, let forecast = forecast  {
                    CityTextView(viewModel: .init(weather: weather, imageProvider: WeatherImageProvider()))
                    WeatherRowView(viewRowModel: .init(forecast: forecast, imageProvider: WeatherImageProvider()))
                } else {
                    LoadingView()
                        .task {
                            do {
                                locationManager.requestLocation()
                                weather = try await
                                weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                                forecast = try await
                                weatherManager.getForecast(latitude: location.latitude, longitude: location.longitude)
                                
                            } catch {
                                print("Error getting weather: \(error)")
                            }
                    }
                }
              }
                else {
            //if locationManager.isLoading {
                       LoadingView()
                           .task {
                               do{
                                   locationManager.requestLocation()
                                   
                               }
                  //         }
                   }
//                    //else {
//                        WelcomeView()
//                          .environmentObject(locationManager)
//                   }
            }
    }
}
}
}
   //Třinec lat/long latitude: 49.67763, longitude: 18.67078

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct BackgroundView: View {
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [ .blue, Color("lightBlue")]),
                       startPoint: .topLeading, endPoint: .bottomTrailing)
        .edgesIgnoringSafeArea(.all)
    }
}
