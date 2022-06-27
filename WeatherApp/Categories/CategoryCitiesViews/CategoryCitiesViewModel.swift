//
//  CategoryCitiesViewModel.swift
//  WeatherApp
//
//  Created by Martin Ficek on 26.06.2022.
//

import Foundation

final class LocationViewModel: ObservableObject{
    @Published var searchText = ""
    private var mapAPI = MapAPI()
    private var weatherManager = WeatherManager(apiClient: APIClient())
    @Published var weather: CurrentWeather?
    @Published var forecast: ForecastWeather?
    @Published var Mode = true
    var sunrise = "Non"
    var sunset = "Non"
    
    init() {
        
    }
    
    func searchButtonDidTap() {
        getWeather()
    }
    
    
    func onAppear() {
        getWeather()
    }
}

private extension LocationViewModel {
    func getWeather() {
        if searchText.isEmpty {
            Task { @MainActor in
                let weather = try await self.weatherManager.getCurrentWeather(latitude: 50.0833, longitude: 14.4667)
                let forecast = try await self.weatherManager.getForecast(latitude: 50.0833, longitude: 14.4667)
                
                self.Mode = isNight(dt: weather.dt, sunset: weather.sys.sunset, sunrise: weather.sys.sunrise)
                self.sunrise = dtToHours(dt: weather.sys.sunrise)
                self.sunset = dtToHours(dt: weather.sys.sunset)
                
                self.weather = weather
                self.forecast = forecast
            }
        } else {
            mapAPI.getLocation(address: searchText) { [weak self] address in
                guard let self = self else { return }
                
                DispatchQueue.main.async {
                    let lati = address.data.first?.latitude ?? 50.0833
                    let long = address.data.last?.longitude ?? 14.4667
                    
                    Task {
                        self.weather = try await self.weatherManager.getCurrentWeather(latitude: lati, longitude: long)
                        self.forecast = try await self.weatherManager.getForecast(latitude: lati, longitude: long)
                    }
                    
                    if let weather = self.weather{
                        self.Mode = isNight(dt: weather.dt, sunset: weather.sys.sunset, sunrise: weather.sys.sunrise)
                        self.sunrise = dtToHours(dt: weather.sys.sunrise)
                        self.sunset = dtToHours(dt: weather.sys.sunset)
                    }
                }
            }
        }
    }
}

