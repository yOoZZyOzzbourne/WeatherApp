//
//  DayAndNight.swift
//  WeatherApp
//
//  Created by Martin Ficek on 14.06.2022.
//

import SwiftUI

//struct DayAndNightModel{
//    private let weather: CurrentWeather
//
//    init(weather: CurrentWeather) {
//     self.weather = weather
//    }
//    var sunrise: Int {
//        weather.sys.sunrise
//    }
//    var sunset: Int {
//        weather.sys.sunset
//    }
//    var dt: Int {
//        weather.dt
//    }
//
//
//
//}


func isNight(dt: Int, sunset: Int, sunrise: Int) ->Bool{
  
    if dt > sunset || dt < sunrise{
        return false
    }
    else{
       return true
    }
}
