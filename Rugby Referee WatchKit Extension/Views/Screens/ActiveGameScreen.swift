//
//  ActiveGameScreen.swift
//  Rugby Referee WatchKit Extension
//
//  Created by Jakub Charvat on 17.06.2021.
//

import SwiftUI

struct ActiveGameScreen: View {
    @EnvironmentObject private var trackedGame: TrackedGame
    
    private enum ActiveScreen {
        case teamA, timer, teamB
    }
    
    @State private var activeScreen: ActiveScreen = .timer
    
    var body: some View {
        TabView(selection: $activeScreen) {
            CardSelectionScreen(team: trackedGame.game.teamA)
                .tag(ActiveScreen.teamA)
            TimerScreen()
                .tag(ActiveScreen.timer)
            CardSelectionScreen(team: trackedGame.game.teamB)
                .tag(ActiveScreen.teamB)
        }
        .tabViewStyle(.page)
    }
}

struct ActiveGameScreen_Previews: PreviewProvider {
    static var previews: some View {
        ActiveGameScreen()
    }
}
