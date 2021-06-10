//
//  Color+Lerp.swift
//  Rugby Referee WatchKit Extension
//
//  Created by Jakub Charvat on 10.06.2021.
//

import SwiftUI


extension Color {
    static func lerp(from: Color, to: Color, distance: Double) -> Color {
        let distance = min(max(distance, 0), 1)
        
        guard let fromComponents = from.colorComponents,
              let toComponents = to.colorComponents else { return .pink }
        
        let red = Double.lerp(from: fromComponents.red, to: toComponents.red, distance: distance)
        let green = Double.lerp(from: fromComponents.green, to: toComponents.green, distance: distance)
        let blue = Double.lerp(from: fromComponents.blue, to: toComponents.blue, distance: distance)
        let opacity = Double.lerp(from: fromComponents.alpha, to: toComponents.alpha, distance: distance)

        return Color(.displayP3, red: red, green: green, blue: blue, opacity: opacity)
    }
}
