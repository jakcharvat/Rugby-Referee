//
//  Game.swift
//  Rugby Referee WatchKit Extension
//
//  Created by Jakub Charvat on 09.06.2021.
//

import Foundation

struct Game: Codable, Identifiable {
    init(teamA: Team, teamB: Team, halfTime: Int) {
        self.teamA = teamA
        self.teamB = teamB
        self.halftimeDuration = halfTime
        self.events = []
        id = UUID()
    }
    
    let id: UUID
    
    let halftimeDuration: Int
    let teamA: Team
    let teamB: Team
    var events: [Event]
}
