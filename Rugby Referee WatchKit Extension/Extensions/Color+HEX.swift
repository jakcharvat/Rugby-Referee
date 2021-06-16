//
//  Color+HEX.swift
//  Rugby Referee WatchKit Extension
//
//  Created by Jakub Charvat on 16.06.2021.
//

import SwiftUI


extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
    
    var hexString: String? {
        guard let components = colorComponents else { return nil }
        
        let red = hexComponent(for: components.red)
        let green = hexComponent(for: components.green)
        let blue = hexComponent(for: components.blue)
        let alpha = hexComponent(for: components.alpha)
        
        print(red, green, blue, alpha)
        
        return "#\(red)\(green)\(blue)\(alpha)"
    }
     
    func hexComponent(for component: Double) -> String {
        let val = Int(component * 255)
        return String(val, radix: 16, uppercase: true)
    }
}
