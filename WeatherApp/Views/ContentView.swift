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
    @State var Mode = true// True - is -> DAY / False - is -> NIGHT
  // @State var dayModel : DayAndNightModel?
    
    
    var body: some View {
        ZStack{
            
            BackgroundView(Mode: $Mode)
            
            TabView{
                
            }
            VStack(spacing: 15) {
                if let location = locationManager.location {
                    if let weather = weather, let forecast = forecast  {
                        CityTextView(viewModel: .init(weather: weather, imageProvider: WeatherImageProvider()),Mode: .constant(Mode))
                        WeatherRowView(viewRowModel: .init(forecast: forecast, imageProvider: WeatherImageProvider()))
                        Text("Dt= \(weather.dt) ")
                        Text("Sunrise= \(weather.sys.sunrise) ")
                        Text("Sunset= \(weather.sys.sunset)")
                        
                    } else {
                        LoadingView()
                            .task {
                                do {
                                    locationManager.requestLocation()
                                    weather = try await
                                    weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                                    forecast = try await
                                    weatherManager.getForecast(latitude: location.latitude, longitude: location.longitude)
                                    
                                    if let weather = weather {
                                        Mode = isNight(dt: weather.dt, sunset: weather.sys.sunset, sunrise: weather.sys.sunrise)
                                    }
                                } catch {
                                    print("Error getting weather: \(error)")
                                }
                                
                            }
                    }
                }
                else {
                    LoadingView()
                        .task {
                            do{
                                locationManager.requestLocation()
                            }
                        }
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
    @Binding var Mode : Bool
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Mode ? .blue: .black,  Mode ? Color("lightBlue") : .gray]),
                       startPoint: .topLeading, endPoint: .bottomTrailing)
        .edgesIgnoringSafeArea(.all)
    }
}


