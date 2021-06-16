//
//  Color+Codable.swift
//  Rugby Referee WatchKit Extension
//
//  Created by Jakub Charvat on 09.06.2021.
//

import SwiftUI


#if os(iOS)
import UIKit
#elseif os(watchOS)
import WatchKit
#elseif os(macOS)
import AppKit
#endif

extension Color {
    #if os(macOS)
    typealias SystemColor = NSColor
    #else
    typealias SystemColor = UIColor
    #endif
    
    /// Get the RGBA components of the colour
    /// - Returns: The RGB components of the colour if it is convertible to RGB. On iOS a colour using the HSB colour space will return nil
    var colorComponents: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)? {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        #if os(macOS)
        SystemColor(self).getRed(&r, green: &g, blue: &b, alpha: &a)
        // Note that non RGB color will raise an exception, that I don't now how to catch because it is an Objc exception.
        #else
        guard SystemColor(self).getRed(&r, green: &g, blue: &b, alpha: &a) else {
            // Pay attention that the color should be convertible into RGB format
            // Colors using hue, saturation and brightness won't work
            return nil
        }
        #endif
        
        return (r, g, b, a)
    }
}

extension Color: Codable {
    enum CodingKeys: String, CodingKey {
        case red, green, blue
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let string = try container.decode(String.self)
        self.init(hex: string)
    }

    public func encode(to encoder: Encoder) throws {
        guard let hex = hexString else { throw CodingError.unableToCreateHexString }
        var container = encoder.singleValueContainer()
        try container.encode(hex)
    }
    
    enum CodingError: Error {
        case unableToCreateHexString
    }
}
