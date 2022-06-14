//
//  WeatherRowView.swift
//  WeatherApp
//
//  Created by Martin Ficek on 10.06.2022.
//

import SwiftUI


struct WeatherRowView: View {
    @ObservedObject var viewRowModel: WeatherRowViewModel

    var body: some View {
        HStack(spacing: 10) {
            ForEach(viewRowModel.daysInWeek()) { day in
                
                    DayWeatherView(
                        dayOfWeek: day.day,
                        imageName: day.imageName,
                        temperature: day.temperature
                    )
                
                
            }
        }
    }
}

//struct WeatherRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        WeatherRowView(viewRowModel: WeatherRowViewModel(forecast: ForecastWeather(cod: <#T##String#>, message: <#T##Int#>, cnt: <#T##Int#>, list: <#T##[List]#>, city: <#T##City#>), imageProvider: <#T##WeatherImageProvider#>))
//            .background(.black)
//    }
//}
//





