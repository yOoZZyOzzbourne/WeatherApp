//
//  CategoryDays.swift
//  WeatherApp
//
//  Created by Martin Ficek on 15.06.2022.
//

import SwiftUI

struct CategoryDays: View {
    @StateObject var locationManager = LocationManager()
    @Binding var Mode : Bool
    @State var forecast: ForecastWeather?
    var weatherManager = WeatherManager(apiClient: APIClient())
    
    
    var body: some View {
        ZStack{
            BackgroundView(Mode: $Mode)
         
            ScrollView{
                VStack(spacing: 15) {
                    if let location = locationManager.location {
                       if let forecast = forecast  {
                        
                               ForecastDayRow(viewForecastRowModel: .init(forecast: forecast, imageProvider: WeatherImageProvider()), Mode: $Mode)
                                   .padding()
                           
    //                        Text("Dt= \(weather.dt) ")
    //                        Text("Sunrise= \(weather.sys.sunrise) ")
    //                        Text("Sunset= \(weather.sys.sunset)")
    //
                        }else {
                            LoadingView()
                                .task {
                                    do {
                                        locationManager.requestLocation()
                                        forecast = try await
                                        weatherManager.getForecast(latitude: location.latitude, longitude: location.longitude)
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
                .padding(.top, 30)
            }
            
        }
        
    }
}


struct CategoryDays_Previews: PreviewProvider {
    static var previews: some View {
        CategoryDays(Mode: .constant(true))
    }
}

