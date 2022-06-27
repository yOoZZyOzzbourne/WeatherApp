//
//  CityDayModel.swift
//  WeatherApp
//
//  Created by Martin Ficek on 22.06.2022.
//

import Foundation
import MapKit
import CoreData


// Address Data Model
struct Address: Codable {
    let data: [Datum]
}

struct Datum: Codable {
    let latitude: Double
    let longitude: Double
}


class MapAPI: ObservableObject{
    private let BASE_URL = "http://api.positionstack.com/v1/forward"
    private let API_KEY = "8d1705695223925a00f73f3eb4f31373"
    
    @Published var coordinates = []
    
    init() {
    }
    
    // API request
    func getLocation(address: String, completion: @escaping (Address) -> Void) {
        let pAddress = address.replacingOccurrences(of: "", with: "%20")
        let url_string = "\(BASE_URL)?access_key=\(API_KEY)&query=\(pAddress)"
        
        guard let url = URL(string: url_string) else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                print(error!.localizedDescription)
                return}
            
            guard let newCoordinates = try? JSONDecoder().decode(Address.self, from: data) else { return }
            
            if newCoordinates.data.isEmpty {
                print("Could not find address...")
                return
            }
            
            completion(newCoordinates)
        }
        .resume()
    }
}


