//
//  Team.swift
//  Rugby Referee WatchKit Extension
//
//  Created by Jakub Charvat on 09.06.2021.
//

import SwiftUI


struct Team: Codable, Identifiable, Equatable {
    let name: String
    let acronym: String
    let colour: Color
    
    var id: String { acronym }
    
    static func == (lhs: Team, rhs: Team) -> Bool {
        return lhs.id == rhs.id
    }
}


#if DEBUG
extension Team {
    static var empty: Team {
        Team(name: "", acronym: "", colour: .clear)
    }
}
#endif
