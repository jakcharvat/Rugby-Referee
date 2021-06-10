//
//  Color+HSL.swift
//  Rugby Referee WatchKit Extension
//
//  Created by Jakub Charvat on 10.06.2021.
//

import SwiftUI


extension Color {
    /// Initialise a colour from its hue saturation and lightness components
    /// - Parameters:
    ///   - hue: Hue (0...1)
    ///   - saturation: Saturation (0...1)
    ///   - lightness: Ligtness (0...1)
    ///   - opacity: Opacity (0...1)
    init(hue: Double, saturation: Double, lightness: Double, opacity: Double) {
        precondition(0...1 ~= hue &&
                     0...1 ~= saturation &&
                     0...1 ~= lightness &&
                     0...1 ~= opacity, "input range is out of range 0...1")
        
        //From HSL TO HSB ---------
        var newSaturation: Double = 0.0
        
        let brightness = lightness + saturation * min(lightness, 1-lightness)
        
        if brightness == 0 { newSaturation = 0.0 }
        else {
            newSaturation = 2 * (1 - lightness / brightness)
        }
        //---------
        
        self.init(hue: hue, saturation: newSaturation, brightness: brightness, opacity: opacity)
    }
}
