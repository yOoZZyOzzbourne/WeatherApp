//
//  ContentView.swift
//  WeatherApp
//
//  Created by Martin Ficek on 10.06.2022.
//

import SwiftUI

struct ContentView: View {
    @State var Mode = true // True - is -> DAY / False - is -> NIGHT
    @State private var selection: Tab = .home
    
    enum Tab{
        case home
        case list
        case otherLocation
        case graphs
    }
    
    var body: some View {
    
        TabView(selection: $selection){
        
            CategoryCities(viewModel: .init())
                .tabItem{
                    Label("Cities", systemImage: "location.fill")
                }
            
            CategoryHome(Mode: $Mode)
                .tabItem{
                    Label("Home", systemImage: "house")
                }
                .tag(Tab.home)

            CategoryDays(Mode: $Mode)
                .tabItem {
                    Label("List", systemImage: "list.bullet")
                }
                .tag(Tab.list)
            
            CategoryGraphs()
                .tabItem{
                    Label("Graphs", systemImage: "list.bullet")
                }
            
           
            
        }
        .tabViewStyle(.page)
        .edgesIgnoringSafeArea(.top)
    }
}
  
struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}

struct BackgroundView: View {
    @Binding var Mode : Bool
    
    var body: some View {
        LinearGradient(gradient:Gradient(colors: [Mode ? .blue : .black,  Mode ? Color(red: 0.143, green: 0.150, blue: 0.250) : .gray]),
                       startPoint: .topLeading, endPoint: .bottomTrailing)
        .edgesIgnoringSafeArea(.top)
    }
}


//Třinec lat/long latitude: 49.67763, longitude: 18.67078

