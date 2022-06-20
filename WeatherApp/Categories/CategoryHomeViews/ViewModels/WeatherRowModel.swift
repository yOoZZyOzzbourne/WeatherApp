//
//  WeatherRowModel.swift
//  WeatherApp
//
//  Created by Martin Ficek on 12.06.2022.
//

import Foundation
import SwiftUI

struct WeatherRowModel: Identifiable {
    var id : String { day }
    let day: String
    let imageName: String
    let temperature: Int
}

final class WeatherRowViewModel: ObservableObject {
    private let forecast: ForecastWeather
    private let imageProvider: WeatherImageProvider
    
    
    
    init(forecast: ForecastWeather, imageProvider: WeatherImageProvider) {
        self.forecast = forecast
        self.imageProvider = imageProvider
    }
    
   
    
    func daysInWeek() -> [WeatherRowModel] {
        let dayNameFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = .current
            dateFormatter.calendar = .current
            dateFormatter.dateFormat = "ccc"
            return dateFormatter
        }()
        
  
        
        return forecast.list
            .filter { $0.dtTxt.hasSuffix("12:00:00") }
            .map { day in
    
                    let date = Date(timeIntervalSince1970: Double(day.dt))
                    let dayName = dayNameFormatter.string(from: date)
                    let imageName = day.weather.first.map { imageProvider.getImage(by: $0.id) } ?? "exclamationmark.triangle"
                    let temperature = Int(day.main.feelsLike)
                    
                    return WeatherRowModel(day: dayName, imageName: imageName, temperature: temperature)
                
               
            }
    }
}
