//
//  Player.swift
//  Rugby Referee WatchKit Extension
//
//  Created by Jakub Charvat on 09.06.2021.
//

import Foundation


struct Player: Codable, Identifiable, Equatable {
    let number: Int
    let team: Team
    
    var id: String {
        "\(team.id)\(number)"
    }
    
    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.id == rhs.id
    }
}
