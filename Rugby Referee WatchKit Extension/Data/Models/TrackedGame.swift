//
//  TrackedGame.swift
//  Rugby Referee WatchKit Extension
//
//  Created by Jakub Charvat on 09.06.2021.
//

import SwiftUI


class TrackedGame: ObservableObject {
    init(teamA: Team, teamB: Team, halfTime: Int) {
        game = Game(teamA: teamA, teamB: teamB, halfTime: halfTime)
        halftimeDuration = TimeInterval(halfTime) /* * 60 */
    }
    
    private let halftimeDuration: TimeInterval

    @Published private(set) var game: Game
    
    let startTime: Date = Date()
    @Published private(set) var elapsedTimeUntilLastPause: TimeInterval = 0
    @Published private(set) var currentGameSegmentStartTime: Date?
    
    @Published private var timeTicker: Timer?
    @Published private var timeElapsed: TimeInterval = 0
    
    @Published var isOvertime = false
    
    var timeRemaining: TimeInterval {
        halftimeDuration - timeElapsed
    }
    
    var paused: Bool {
        return currentGameSegmentStartTime == nil
    }
    
    func pause() {
        guard let currentGameSegmentStartTime = currentGameSegmentStartTime else { return }

        timeTicker?.invalidate()
        let currTime = Date()
        let fromStart = currentGameSegmentStartTime.distance(to: currTime)
        elapsedTimeUntilLastPause += fromStart
        self.currentGameSegmentStartTime = nil
    }
    
    func resume() {
        guard currentGameSegmentStartTime == nil else { return }
        currentGameSegmentStartTime = Date()
        
        timeTicker = .scheduledTimer(withTimeInterval: 0.1, repeats: true, block: updateElapsedTime(_:))
    }
    
    func togglePaused() {
        if paused { resume() }
        else { pause() }
    }
    
    private func updateElapsedTime(_ timer: Timer) {
        guard let currentGameSegmentStartTime = currentGameSegmentStartTime else { return }

        let now = Date()
        let currentGameSegmentTime = currentGameSegmentStartTime.distance(to: now)
        timeElapsed = elapsedTimeUntilLastPause + currentGameSegmentTime
        isOvertime = timeElapsed > halftimeDuration
    }
}
