//
//  ForecastRowModel.swift
//  WeatherApp
//
//  Created by Martin Ficek on 15.06.2022.
//

import Foundation
import SwiftUI

struct ForecastRowModel: Identifiable {
    var id : String { day }
    let day: String
    let dtTxT : String
    
}

struct WeatherInDayModel: Identifiable{
    var id : String { day }
    let day : String
    let dtTxt : String
    let imageName: String
    let temperature: Int
}

final class ForecastRowViewModel: ObservableObject {
    private let forecast: ForecastWeather
    private let imageProvider: WeatherImageProvider
    
    
    
    init(forecast: ForecastWeather, imageProvider: WeatherImageProvider) {
        self.forecast = forecast
        self.imageProvider = imageProvider
    }
    
   
    func daysInWeek() -> [ForecastRowModel] {
        let dayNameFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = .current
            dateFormatter.calendar = .current
            dateFormatter.dateFormat = "ccc"
            return dateFormatter
        }()
        

        return forecast.list
      .filter { $0.dtTxt.hasSuffix("21:00:00") }
            .map { day in
    
                    let date = Date(timeIntervalSince1970: Double(day.dt))
                    let dayName = dayNameFormatter.string(from: date)
                    let dtTxT = day.dtTxt
                    
                return ForecastRowModel(day: dayName, dtTxT: dtTxT)
            }
    }
    
    
    func weatherInDay(dtT: String) -> [WeatherInDayModel]{
        let dayNameFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = .current
            dateFormatter.calendar = .current
            dateFormatter.dateFormat = "ccc"
            return dateFormatter
        }()
        
        return forecast.list
            .filter{ $0.dtTxt.contains(dtT) }
            .map{ time in
            
                    let date = Date(timeIntervalSince1970: Double(time.dt))
                    let dayName = dayNameFormatter.string(from: date)
                    let imageName = time.weather.first.map{ imageProvider.getImage(by: $0.id) } ?? "exclamationmark.triangle"
                    let temperature = Int(time.main.feelsLike)
                let dtTxT = time.dtTxt.suffix(7)
                
                return WeatherInDayModel(day: dayName, dtTxt: String(dtTxT), imageName: imageName, temperature: temperature)
            }
        
        
    }
}
