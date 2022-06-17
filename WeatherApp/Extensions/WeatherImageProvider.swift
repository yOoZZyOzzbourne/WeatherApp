//
//  WeatherImageProvider.swift
//  WeatherApp
//
//  Created by Martin Ficek on 12.06.2022.
//

import Foundation
import SwiftUI

struct WeatherImageProvider {
    func getImage(by id: Int) -> String {
        switch id{
        case 200...232:
            return "cloud.bolt.rain"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain.fill"
        case 600...622:
            return "cloud.snow.fill"
        case 701...781:
            return "cloud.fog.fill"
        case 800:
            return "sun.max.fill"
        case 801:
            return "cloud.sun.fill"
        case 802:
            return "cloud.sun.fill"
        case 803:
            return "cloud.fill"
        case 804:
            return "smoke.fill"
        default:
            return "cloud"
        }
    }
}
