//
//  CategoryHome.swift
//  WeatherApp
//
//  Created by Martin Ficek on 15.06.2022.
//

import SwiftUI

struct CategoryHome: View {
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager(apiClient: APIClient())
    @State var weather: CurrentWeather?
    @State var forecast: ForecastWeather?
    @Binding var Mode :Bool// True - is -> DAY / False - is -> NIGHT
  // @State var dayModel : DayAndNightModel?
    
    
    var body: some View {
        ZStack{
            
            BackgroundView(Mode: $Mode)
            
            VStack(spacing: 15) {
                if let location = locationManager.location {
                    if let weather = weather, let forecast = forecast  {
                        CityTextView(viewModel: .init(weather: weather, imageProvider: WeatherImageProvider()),Mode: .constant(Mode))
                        WeatherRowView(viewRowModel: .init(forecast: forecast, imageProvider: WeatherImageProvider()))
//                        Text("Dt= \(weather.dt) ")
//                        Text("Sunrise= \(weather.sys.sunrise) ")
//                        Text("Sunset= \(weather.sys.sunset)")
//                        
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

struct CategoryHome_Previews: PreviewProvider {
    static var previews: some View {
        CategoryHome(Mode: .constant(true))
    }
}
