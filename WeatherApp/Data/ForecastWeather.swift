//
//  ForecastWeather.swift
//  WeatherApp
//
//  Created by Martin Ficek on 12.06.2022.
//

import Foundation

struct ForecastWeather: Decodable {
    let cod: String
    let message, cnt: Int
    let list: [List]
    let city: City
}

struct City: Decodable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let timezone: Int
    let sunrise: Int
    let sunset: Int
}


struct Coord: Decodable {
    let lat: Double
    let lon: Double
}

struct List: Decodable, Identifiable {
    var id: Int { dt }
    
    let dt: Int
    let main: MainClass
    let weather: [Weather]
    let dtTxt: String
    

    enum CodingKeys: String, CodingKey {
        case dt, main, weather
        case dtTxt = "dt_txt"
    }
}

struct MainClass: Decodable {
    let temp, feelsLike, tempMin, tempMax: Double
    let tempKf: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case tempKf = "temp_kf"
    }
}

// MARK: - Weather
struct Weather: Decodable {
    let id: Int
}
