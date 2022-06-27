//
//  CityDay.swift
//  WeatherApp
//
//  Created by Martin Ficek on 21.06.2022.
//

import SwiftUI

struct CategoryCities: View {
    @StateObject var viewModel :LocationViewModel
  
    var body: some View {
        ZStack{
            
            BackgroundView(Mode: $viewModel.Mode)
            ScrollView{
                VStack(spacing: 40) {
                
                    ZStack {
                        TextField("Enter an address", text: $viewModel.searchText)
                       .textFieldStyle(.roundedBorder)
                       .frame(width: 355, height: 50)
                       .padding(.leading, 25)
                       
                    Button("Cancel") {
                        withAnimation {
                         UIApplication.shared.dismissKeyboard()
                        }
                    }
                    .padding(.leading, 260)
                    .scaledToFit()
                    }
                    .padding(.leading, -30)
                    
                    if let weather = viewModel.weather, let forecast = viewModel.forecast{
                     
                        Button() {
                            viewModel.searchButtonDidTap()
                            
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 30)
                                    .foregroundColor(.black)
                                Text("Find Adress")
                                    .foregroundColor(.white)
                            } .frame(width: 150, height: 20)
                           
                        }
                        .padding(.leading, -30)
                        
                        CityTextView(viewModel: .init(weather: weather, imageProvider: WeatherImageProvider()),Mode: .constant(viewModel.Mode))
                            
                        WeatherRowView(viewRowModel: .init(forecast: forecast, imageProvider: WeatherImageProvider()))
                        
                        SunriseSunset(sunrise: viewModel.sunrise, sunset: viewModel.sunset)
                       
                    } else {
                        LoadingView()
                    }
                
                }
                .onAppear {
                    viewModel.onAppear()
                }
                .padding(80)
            }
            
        }
    }
}

struct CityDay_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCities(viewModel: .init())
            //.previewInterfaceOrientation(.portraitUpsideDown)
    }
}



