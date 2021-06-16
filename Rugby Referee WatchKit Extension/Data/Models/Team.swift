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
    static var teams: [Team] = {
        let res = Bundle.main.url(forResource: "Teams", withExtension: "json")!
        let data = try! Data(contentsOf: res)
        return try! JSONDecoder().decode([Team].self, from: data)
    }()
    
    static var empty: Team {
        Team(name: "", acronym: "", colour: .clear)
    }
    
    static var sample1: Team {
        teams[0]
    }
    
    static var sample2: Team {
        teams[1]
    }
}
#endif
