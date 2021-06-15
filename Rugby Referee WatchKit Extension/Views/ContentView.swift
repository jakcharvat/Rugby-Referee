//
//  ContentView.swift
//  Rugby Referee WatchKit Extension
//
//  Created by Jakub Charvat on 09.06.2021.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var game = TrackedGame(teamA: .empty, teamB: .empty, halfTime: 10)
    
    @State private var num = 1
    
    var body: some View {
//        TimerView().environmentObject(game)
        
        NumberPicker("Player", in: 1...30, selection: $num)
        
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
