//
//  Extension.swift
//  WeatherApp
//
//  Created by Martin Ficek on 10.06.2022.
//

import Foundation
import SwiftUI

extension Double {
    var roundDouble: String {
        String(format: "%.0f", self)
    }
}

extension UIApplication {
     func dismissKeyboard() {
         sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
     }
 }
