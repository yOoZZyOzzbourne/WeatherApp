//
//  SunriseSunset.swift
//  WeatherApp
//
//  Created by Martin Ficek on 17.06.2022.
//

import SwiftUI

struct SunriseSunset: View {
    var sunrise = "03:30"
    var sunset = "21:22"
    
    var body: some View {
        HStack{
            VStack{
                Image(systemName:"sunrise.fill")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 60)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 55, height: 55)
                Text(sunrise)
                    .font(.title)
            }
            VStack{
                Image(systemName:"sunset.fill")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 60)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 55, height: 55)
                Text(sunset)
                    .font(.title)
            }
        }
        .foregroundColor(.white)
    }
}

struct SunriseSunset_Previews: PreviewProvider {
    static var previews: some View {
        SunriseSunset()
            .foregroundColor(.black)
    }
}
