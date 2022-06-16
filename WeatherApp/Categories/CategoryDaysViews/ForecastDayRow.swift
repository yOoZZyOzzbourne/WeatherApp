//
//  ForecastDayRow.swift
//  WeatherApp
//
//  Created by Martin Ficek on 15.06.2022.
//

import SwiftUI

struct ForecastDayRow: View {
    @ObservedObject var viewForecastRowModel: ForecastRowViewModel
    @Binding var Mode : Bool
    
    var body: some View {
        VStack{

        ForEach(viewForecastRowModel.daysInWeek()){ day in
            HStack{
            Text("\(day.day)")
                .foregroundColor(.white)
                .font(.title)
            
        ScrollView(.horizontal, showsIndicators: false){
            HStack(alignment: .top, spacing: 10){
     
                ForEach(viewForecastRowModel.weatherInDay(dtT: String(day.dtTxT.prefix(10)))){ time in
                        ForecastDay(time: String(time.dtTxt.prefix(5)), imageName: time.imageName, temperature: time.temperature)
                            }
                    
                        }
                    }
                    .padding(.leading, 20)
                }
                .padding()
            }
        }
    }
}
//
//struct ForecastDayRow_Previews: PreviewProvider {
//    static var previews: some View {
//        ForecastDayRow(viewForecastRowModel: .init(forecast: <#T##ForecastWeather#>, imageProvider: WeatherImageProvider()))
//    }
//}
