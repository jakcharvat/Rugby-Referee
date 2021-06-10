//
//  ContentView.swift
//  Rugby Referee WatchKit Extension
//
//  Created by Jakub Charvat on 09.06.2021.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var game = ObservableTrackedGame(teamA: .empty, teamB: .empty)
    
    var body: some View {
        VStack {
            
            Text(game.elapsedStartTime, style: .timer)
            
            Button("Pause") {
                game.pause()
            }
            
            Button("Resume") {
                game.resume()
            }
        }
        
//        HomeScreen()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AllSizes {
            ContentView()
        }
    }
}
