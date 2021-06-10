//
//  HomeScreen.swift
//  Rugby Referee WatchKit Extension
//
//  Created by Jakub Charvat on 09.06.2021.
//

import SwiftUI

struct HomeScreen: View {
    var body: some View {
//        NavigationView {
            List {
                navigationLink("Matches") {
                    Text("Matches")
                }
                navigationLink("New Match") {
                    Text("New Match")
                }
                
                Section {
                    Text("Past Games")
                        .font(.headline)
                        .listRowPlatterColor(.clear)
                    navigationLink("Game1") {
                        Text("Game 1")
                    }
                }
            }
            .navigationTitle("Rugby Referee")
//        }
    }
    
    
    @ViewBuilder
    func navigationLink<Destination>(_ name: String, @ViewBuilder destination: () -> Destination) -> some View where Destination: View {
        NavigationLink(destination: destination().navigationTitle(name)) {
            Text(name)
                .font(.title2)
                .bold()
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        AllSizes {
            HomeScreen()
        }
    }
}
