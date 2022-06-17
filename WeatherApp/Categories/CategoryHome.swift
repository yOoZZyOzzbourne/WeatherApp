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
    @Binding var Mode :Bool
    @State var sunrise = "Non"
    @State var sunset = "Non"
    
    var body: some View {
        ZStack{
            
            BackgroundView(Mode: $Mode)
            ScrollView{
                VStack(spacing: 40) {
                if let location = locationManager.location {
                    if let weather = weather, let forecast = forecast  {
                        CityTextView(viewModel: .init(weather: weather, imageProvider: WeatherImageProvider()),Mode: .constant(Mode))
                            
                        WeatherRowView(viewRowModel: .init(forecast: forecast, imageProvider: WeatherImageProvider()))
                        
                        SunriseSunset(sunrise: sunrise, sunset: sunset)
                       
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
                                        sunrise = dtToHours(dt: weather.sys.sunrise)
                                        sunset = dtToHours(dt: weather.sys.sunset)
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
                .padding(80)
            }
            
        }
    }
}

struct CategoryHome_Previews: PreviewProvider {
    static var previews: some View {
        CategoryHome(Mode: .constant(true))
    }
}
