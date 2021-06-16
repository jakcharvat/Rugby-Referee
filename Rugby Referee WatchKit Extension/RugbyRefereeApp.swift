//
//  RugbyRefereeApp.swift
//  Rugby Referee WatchKit Extension
//
//  Created by Jakub Charvat on 09.06.2021.
//

import SwiftUI

@main
struct RugbyRefereeApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
            .onAppear {
                let res = Bundle.main.url(forResource: "Teams", withExtension: "json")!
                let data = try! Data(contentsOf: res)
                print(try! JSONDecoder().decode([Team].self, from: data))
            }
        }
    }
}
