//
//  Event.swift
//  Rugby Referee WatchKit Extension
//
//  Created by Jakub Charvat on 09.06.2021.
//

import Foundation


struct Event: Codable, Identifiable, Comparable {
    let player: Player
    let time: Double
    let type: EventType
    
    private(set) var id = UUID()
    
    static func == (lhs: Event, rhs: Event) -> Bool {
        lhs.id == rhs.id
    }
    
    static func < (lhs: Event, rhs: Event) -> Bool {
        if lhs.time != rhs.time { return lhs.time < rhs.time }
        if lhs.type != rhs.type { return lhs.type < rhs.type }
        return lhs.player.id < rhs.player.id
    }
}


enum EventType: Codable, Comparable {
    case redCard
    case yellowCard
    case goal
}
