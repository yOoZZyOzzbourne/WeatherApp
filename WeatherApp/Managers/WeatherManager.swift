//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Martin Ficek on 10.06.2022.
//

import Foundation
import CoreLocation

enum WeatherManagerError: Error {
    case badUrl
}


struct WeatherManager {
    let apiClient: APIClientType
    
    // MARK: - Request weather to Open Weather
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> CurrentWeather {
        guard let url = URL(string: "\(Constants.baseUrl)/weather?lat=\(latitude)&lon=\(longitude)&appid=\(Constants.appId)&units=metric")
        else {
            throw WeatherManagerError.badUrl
        }
        
        return try await apiClient.request(url: url)
    }
    
    func getForecast(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ForecastWeather {
        guard let forecastUrl = URL(string: "\(Constants.baseUrl)/forecast?lat=\(latitude)&lon=\(longitude)&appid=\(Constants.appId)&units=metric")
        else {
            throw WeatherManagerError.badUrl
       }
        
        return try await apiClient.request(url: forecastUrl)
    }
}

struct Constants {
    static let baseUrl = "https://api.openweathermap.org/data/2.5"
    static let appId = "e4beb8856641ae18bf5c39e7832c1a67"
}

protocol APIClientType {
    func request<T: Decodable>(url: URL) async throws -> T
}

struct APIClient: APIClientType {
    func request<T: Decodable>(url: URL) async throws -> T {
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error fetching weather data")
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}



//enum PositionManagerError: Error{
//    case badUrl
//}
//
//struct PositionManager {
//    let apiClient: APIClientType
//    private let BASE_URL = "http://api.positionstack.com/v1/forward"
//    private let API_KEY = "8d1705695223925a00f73f3eb4f31373"
//
//    // MARK: - Request weather to Open Weather
//    func getPosition(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> CurrentWeather {
//        guard let url = URL(string: "\(Constants.baseUrl)/weather?lat=\(latitude)&lon=\(longitude)&appid=\(Constants.appId)&units=metric")
//        else {
//            throw PositionManagerError.badUrl
//        }
//
//        return try await apiClient.request(url: url)
//    }
//
//}


//https://api.openweathermap.org/data/2.5/weather?lat=49.67763&lon=18.67078&appid=e4beb8856641ae18bf5c39e7832c1a67&units=metric

