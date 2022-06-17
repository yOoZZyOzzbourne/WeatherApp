//
//  DayAndNight.swift
//  WeatherApp
//
//  Created by Martin Ficek on 14.06.2022.
//

import SwiftUI

func isNight(dt: Int, sunset: Int, sunrise: Int) ->Bool{
  
    if dt > sunset || dt < sunrise{
        return false
    }
    else{
       return true
    }
}

func dtToHours(dt: Int) -> String{
    
    let date = Date(timeIntervalSince1970: TimeInterval(Int(dt)))
    
    let dateFormatter = DateFormatter()

   
    dateFormatter.dateFormat = "HH:mm"

  
    let time = dateFormatter.string(from: date)
    
    
    return time
}

