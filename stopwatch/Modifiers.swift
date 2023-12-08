//
//  Modifiers.swift
//  stopwatch
//
//  Created by Kashif on 06/12/23.
//

import Foundation
import SwiftUI

struct borderModifier:ViewModifier{
    func body(content: Content) -> some View {
        content
            .padding(10)
            .frame(width:180, alignment: .topLeading)
            .cornerRadius(10)
            .multilineTextAlignment(.center)
            .overlay(
            RoundedRectangle(cornerRadius: 10)
            .inset(by: 0.5)
            .stroke(Color(red: 0.85, green: 0.86, blue: 0.9), lineWidth: 1)

            )
    }
}


extension View{
    func blockStyle()-> some View{
        modifier(borderModifier())
    }
}


extension Color {
    init(hex: Int, opacity: Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}
