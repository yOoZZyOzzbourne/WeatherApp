//
//  ContentView.swift
//  WeatherApp
//
//  Created by Martin Ficek on 10.06.2022.
//

import SwiftUI

struct ContentView: View {
    @State var Mode = true
    @State private var selection: Tab = .home
    enum Tab{
        case home
        case list
    }
//    init() {
//        UITabBar.appearance().backgroundColor = Mode ? .white : .black
//
//    }
    init() {
        UITabBar.appearance().barTintColor = Mode ? UIColor(Color(.white)) : UIColor(Color(.black)) // custom color.
       }
    
    var body: some View {
       
    
        TabView(selection: $selection){
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
            
        }
        .accentColor(Mode ? Color(UIColor.black) : Color(UIColor.white))
        
     
       
        
    }
}
   //Třinec lat/long latitude: 49.67763, longitude: 18.67078

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}


struct BackgroundView: View {
    @Binding var Mode : Bool
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Mode ? .blue: .black,  Mode ? Color("lightBlue") : .gray]),
                       startPoint: .topLeading, endPoint: .bottomTrailing)
        .edgesIgnoringSafeArea(.top)
    }
}



