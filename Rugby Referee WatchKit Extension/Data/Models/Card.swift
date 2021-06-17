//
//  Card.swift
//  Rugby Referee WatchKit Extension
//
//  Created by Jakub Charvat on 17.06.2021.
//

import SwiftUI


enum Card: Codable {
    case yellow
    case red
    
    var colour: Color {
        switch self {
        case .yellow: return .yellow
        case .red: return .red
        }
    }
}
