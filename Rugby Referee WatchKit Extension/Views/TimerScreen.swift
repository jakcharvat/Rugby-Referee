//
//  TimerScreen.swift
//  Rugby Referee WatchKit Extension
//
//  Created by Jakub Charvat on 16.06.2021.
//

import SwiftUI

struct TimerScreen: View {
    var body: some View {
        VStack {
            GoalCounters()
                .animation(TimerView.animation)
            TimerView()
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct TimerScreen_Previews: PreviewProvider {
    static var previews: some View {
        TimerScreen()
    }
}
