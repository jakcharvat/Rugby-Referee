//
//  Double+Lerp.swift
//  Rugby Referee WatchKit Extension
//
//  Created by Jakub Charvat on 10.06.2021.
//

import Foundation


extension Double {
    static func lerp(from: Double, to: Double, distance: Double) -> Double {
        let distance = min(max(distance, 0), 1)
        return from + (to - from)*distance
    }
    
    func progress(from: Double, to: Double) -> Double {
        let progress = (self - from) / (to - from)
        return min(max(progress, 0), 1)
    }
}
