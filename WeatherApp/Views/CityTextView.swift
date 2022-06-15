//
//  CityTextView.swift
//  WeatherApp
//
//  Created by Martin Ficek on 10.06.2022.
//

import SwiftUI

struct CityTextView: View{
    @ObservedObject var viewModel: CityTextViewModel
    @Binding var Mode : Bool
    
    var body: some View{
        VStack{
            Text(viewModel.name)
                .font(.system(size: 32, weight: .medium, design: .default))
            
        Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
            .fontWeight(.light)
            .font(.subheadline)
            
            Image(systemName:Mode ? viewModel.imageName : "moon.stars.fill")
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 160)
            
            Text(viewModel.feelsLike)
                .font(.system(size: 70, weight: .medium))
                .foregroundColor(.white)
                .padding(.top, -15)
            
            HStack{
                Image(systemName: "arrow.up")
                Text(viewModel.tempMax)
                
                Text(viewModel.tempMin)
                Image(systemName: "arrow.down")
            }
            .font(.system(size: 25, weight: .light))
                .foregroundColor(.white)
        }
        .foregroundColor(.white)
    }
}

struct CityTextView_Previews: PreviewProvider {
    static var previews: some View {
        CityTextView(viewModel: .init(weather: previewWeather, imageProvider: WeatherImageProvider()),Mode: .constant(true))
            .background(.black)
    }
}









   
    
    
    
       
  

