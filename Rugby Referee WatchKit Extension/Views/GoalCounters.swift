//
//  GoalCounters.swift
//  Rugby Referee WatchKit Extension
//
//  Created by Jakub Charvat on 16.06.2021.
//

import SwiftUI

struct GoalCounters: View {
    @EnvironmentObject private var trackedGame: TrackedGame
    
    var body: some View {
        HStack {
            GoalCounter(team: trackedGame.game.teamA, count: $trackedGame.teamAScore)
            GoalCounter(team: trackedGame.game.teamB, count: $trackedGame.teamBScore)
        }
    }
}

struct GoalCounters_Previews: PreviewProvider {
    static var previews: some View {
        GoalCounters()
    }
}
