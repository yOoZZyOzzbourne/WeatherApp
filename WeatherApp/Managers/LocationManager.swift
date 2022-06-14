//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Martin Ficek on 13.06.2022.
//

import Foundation

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    
    @Published var location: CLLocationCoordinate2D?
    @Published var isLoading = false
    
//    func requestL(){
//       manager.requestWhenInUseAuthorization()
//    }

    override init() {
        super.init()
        manager.delegate = self
    }
    
    func requestLocation() {
        isLoading = true
        
       manager.requestAlwaysAuthorization()
       manager.startUpdatingLocation()
       // manager.requestLocation()
     
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.last?.coordinate
        isLoading = false
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Eror getting location", error)
        isLoading = false
    }
    
    
}
