//
//  CityDay.swift
//  WeatherApp
//
//  Created by Martin Ficek on 21.06.2022.
//

import SwiftUI

struct CityDay: View {
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager(apiClient: APIClient())
    @State var weather: CurrentWeather?
    @State var forecast: ForecastWeather?
    @Binding var Mode :Bool
    @State var sunrise = "Non"
    @State var sunset = "Non"
    @State var latitude = 50.0833
    @State var longitude = 14.4667
    @State var button = true
    @StateObject private var mapAPI = MapAPI()
    @State private var searchBar = ""
   
    
    var body: some View {
        ZStack{
            
            BackgroundView(Mode: $Mode)
            ScrollView{
                VStack(spacing: 40) {
                    
                    ZStack(){
                    TextField("Enter an address", text: $searchBar)
                       .textFieldStyle(.roundedBorder)
                       .frame(width: 355, height: 50)
                       
                    Button("Cancel") {
                        withAnimation {
                         UIApplication.shared.dismissKeyboard()
                        }
                    }
                    .padding(.leading, 260)
                    .scaledToFit()
                    }
                    .padding(.leading, -30)
                    
//                     Text("Latitude \(latitude)")
//                     Text("Longitude \(longitude)")
       
                    if let weather = weather, let forecast = forecast, button == true{
                     
                        Button() {
                            mapAPI.getLocation(address: searchBar, delta: 0.5)
                            sleep(2)
                            longitude = mapAPI.long
                            latitude = mapAPI.lati
                            button = false
                      
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 30)
                                    .foregroundColor(.black)
                                Text("Find Adress")
                                    .foregroundColor(.white)
                            } .frame(width: 150, height: 20)
                           
                        }
                        .padding(.leading, -30)
                        
                        CityTextView(viewModel: .init(weather: weather, imageProvider: WeatherImageProvider()),Mode: .constant(Mode))
                            
                        WeatherRowView(viewRowModel: .init(forecast: forecast, imageProvider: WeatherImageProvider()))
                        
                        SunriseSunset(sunrise: sunrise, sunset: sunset)
                       
                    } else {
                        LoadingView()
                            .task {
                                   do {
                                       longitude = mapAPI.long
                                       latitude = mapAPI.lati
                                       
                                    weather = try await
                                    weatherManager.getCurrentWeather(latitude: latitude, longitude: longitude)
                                    forecast = try await
                                    weatherManager.getForecast(latitude: latitude, longitude: longitude)
                                    
                                    if let weather = weather {
                                        Mode = isNight(dt: weather.dt, sunset: weather.sys.sunset, sunrise: weather.sys.sunrise)
                                        sunrise = dtToHours(dt: weather.sys.sunrise)
                                        sunset = dtToHours(dt: weather.sys.sunset)
                                    }
                                    button = true
                                    
                                } catch {
                                    print("Error getting weather: \(error)")
                                }
                            }
                    }
                
                }
                .padding(80)
            }
            
        }
    }
}

struct CityDay_Previews: PreviewProvider {
    static var previews: some View {
        CityDay(Mode: .constant(true))
    }
}
