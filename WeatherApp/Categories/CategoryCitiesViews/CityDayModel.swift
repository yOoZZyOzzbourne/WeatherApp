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
    let latitude:Double
    let longitude: Double
    let name: String?


}

// Our Pin Locations
struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

class MapAPI: ObservableObject{
   private let BASE_URL = "http://api.positionstack.com/v1/forward"
   private let API_KEY = "8d1705695223925a00f73f3eb4f31373"
   
    @Published var region: MKCoordinateRegion
    @Published var coordinates = []
    @Published var locations: [Location] = []
    @Published var lati = 50.0833
    @Published var long = 14.4667

   init() {
      // Defualt Info
      self.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5))
      
      self.locations.insert(Location(name: "Pin", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275)), at: 0)
    
       self.lati = lati
   }
   
   // API request
   func getLocation(address: String, delta: Double) {
      let pAddress = address.replacingOccurrences(of: " ", with: "%20")
      let url_string = "\(BASE_URL)?access_key=\(API_KEY)&query=\(pAddress)"
   
      guard let url = URL(string: url_string) else {
         print("Invalid URL")
         return }
      
      URLSession.shared.dataTask(with: url) { (data, response, error) in
         guard let data = data else {
            print(error!.localizedDescription)
            return}
         
         guard let newCoordinates = try? JSONDecoder().decode(Address.self, from: data) else { return }
         
         if newCoordinates.data.isEmpty {
            print("Could not find address...")
            return
         }
         
         // Set the new data
          DispatchQueue.main.async { [self] in
            let details = newCoordinates.data[0]
            let lat = details.latitude
            let lon = details.longitude
        
            self.coordinates = [lat, lon]
            self.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: lon), span: MKCoordinateSpan(latitudeDelta: delta, longitudeDelta: delta))
            
            let new_location = Location(name: "\(details.name)", coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon))
            
            self.locations.removeAll()
            self.locations.insert(new_location, at: 0)
            
              self.lati = new_location.coordinate.latitude
              self.long = new_location.coordinate.longitude
             
            print("Successfully loaded location! \(details.name)")
         }
      }
      .resume()
   }
}

