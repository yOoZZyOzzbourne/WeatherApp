//
//  ForecastDay.swift
//  WeatherApp
//
//  Created by Martin Ficek on 15.06.2022.
//

import SwiftUI

struct ForecastDay: View {
    var time = "non"
    var imageName = "cloud.sun.fill"
    var temperature = 12
    
    var body: some View {
        VStack(spacing: 8){
            Text(time)
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(.white)
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 45, height: 45)
            Text("\(temperature)°")
                .font(.system(size: 35, weight: .medium))
                .foregroundColor(.white)
        }
    }
}

struct ForecastDay_Previews: PreviewProvider {
    static var previews: some View {
        ForecastDay()
    }
}
