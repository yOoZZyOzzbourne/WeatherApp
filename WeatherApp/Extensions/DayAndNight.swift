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
