//
//  CategoryCities.swift
//  WeatherApp
//
//  Created by Martin Ficek on 20.06.2022.
//

import SwiftUI

struct CategoryCities: View {
    @Binding var Mode : Bool

        var body: some View {
            Text("")
        }
}

struct CategoryCities_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCities(Mode: .constant(true))
    }
}


