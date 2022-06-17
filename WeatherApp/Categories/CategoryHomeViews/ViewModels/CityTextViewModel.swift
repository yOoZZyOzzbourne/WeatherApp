//
//  CityTextViewModel.swift
//  WeatherApp
//
//  Created by Martin Ficek on 12.06.2022.
//

import Foundation
import SwiftUI

final class CityTextViewModel: ObservableObject {
    private let weather: CurrentWeather
    private let imageProvider: WeatherImageProvider
    
    init(weather: CurrentWeather, imageProvider: WeatherImageProvider) {
        self.weather = weather
        self.imageProvider = imageProvider
    }
    
    var name: String {
        weather.name
    }
    
    var feelsLike: String {
        "\(weather.main.feelsLike.roundDouble)°"
    }
    
    var tempMax: String {
        "\(weather.main.tempMax.roundDouble)°"
    }
    
    var tempMin: String {
        "\(weather.main.tempMin.roundDouble)°"
    }
    
    
    var imageName: String {
        guard let idName = weather.weather.first?.id else {
            assertionFailure("WeatherApiFail")
            return "exclamationmark.triangle"
        }
        return imageProvider.getImage(by: idName, dt: "")
    }
}



