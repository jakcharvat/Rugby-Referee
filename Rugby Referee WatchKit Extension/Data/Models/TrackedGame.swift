//
//  TrackedGame.swift
//  Rugby Referee WatchKit Extension
//
//  Created by Jakub Charvat on 09.06.2021.
//

import SwiftUI


struct TrackedGame {
    init(teamA: Team, teamB: Team) {
        game = Game(teamA: teamA, teamB: teamB)
    }
    
    private(set) var game: Game
    
    private let startTime: Date = Date()
    private var pauseTime: TimeInterval = 0
    private var gameTime: TimeInterval = 0
    private var isPaused: Bool = false
    private var lastPauseTime: Date?
    
    var elapsedStartTime: Date {
        if isPaused {
            return Date() - gameTime + 20*60
        }
        return startTime + pauseTime + 20*60
    }
    
    mutating func pause() {
        if isPaused { return }
        isPaused = true

        let currTime = Date()
        let fromStart = startTime.distance(to: currTime)
        gameTime = fromStart - pauseTime
        lastPauseTime = currTime
    }
    
    mutating func resume() {
        if !isPaused { return }
        isPaused = false
        
        let currTime = Date()
        let fromStart = startTime.distance(to: currTime)
        pauseTime = fromStart - gameTime
        lastPauseTime = nil
    }
}


@dynamicMemberLookup
class ObservableTrackedGame: ObservableObject {
    init(teamA: Team, teamB: Team) {
        trackedGame = TrackedGame(teamA: teamA, teamB: teamB)
    }
    
    @Published private var trackedGame: TrackedGame
    
    subscript<T>(dynamicMember keyPath: KeyPath<TrackedGame, T>) -> T {
        return trackedGame[keyPath: keyPath]
    }
    
    
    func pause() {
        trackedGame.pause()
    }
    
    func resume() {
        trackedGame.resume()
    }
}
