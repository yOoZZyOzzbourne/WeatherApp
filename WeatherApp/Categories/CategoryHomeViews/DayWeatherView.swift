//
//  DayWeatherView.swift
//  WeatherApp
//
//  Created by Martin Ficek on 10.06.2022.
//

import SwiftUI

struct DayWeatherView: View {
    var dayOfWeek = "non"
    var imageName = "cloud.sun.fill"
    var temperature : Int
    
    var body: some View {
        VStack(spacing: 8){
            Text(dayOfWeek)
                .font(.system(size: 25, weight: .medium))
                .foregroundColor(.white)
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 65, height: 65)
            Text("\(temperature)°")
                .font(.system(size: 35, weight: .medium))
                .foregroundColor(.white)
        }
    }
}


struct DayWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        DayWeatherView(temperature: 15)
            .background(.black)
    }
}
