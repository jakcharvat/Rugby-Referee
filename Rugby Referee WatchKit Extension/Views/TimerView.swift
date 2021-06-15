//
//  TimerView.swift
//  Rugby Referee WatchKit Extension
//
//  Created by Jakub Charvat on 10.06.2021.
//

import SwiftUI
import WatchKit

struct TimerView: View {
    @EnvironmentObject private var game: TrackedGame
    
    var body: some View {
        VStack {
            Button {
                game.togglePaused()
            } label: {
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        TimerText(for: .minutes)
                        TimerText(for: .colon)
                        TimerText(for: .seconds)
                    }
                    .foregroundColor(.white)
                    .scaleEffect(game.paused ? 0.8 : 1)
                    .offset(y: game.paused ? -3 : 0)
                    
                    if game.paused {
                        Text("PAUSED")
                            .font(.subheadline)
                            .fontWeight(.heavy)
                            .offset(y: -3)
                            .foregroundColor(.orange)
                    }
                }
            }
            .buttonStyle(
                BorderedButtonStyle(
                    tint: tintColour.opacity(tintOpacity*6 + 1)
                )
            )
            
            if game.isOvertime {
                Text("OVERTIME")
                    .font(.subheadline)
                    .fontWeight(.heavy)
                    .foregroundColor(.red)
            }
        }
        .animation(.easeInOut(duration: 0.2))
    }
    
    var tintColour: Color {
        switch game.timeRemaining {
        case (-.infinity)...(-0.1):
            return .redTimerBackground
        case (-0.2)...(0):
            return .lerp(from: .redTimerBackground, to: .orangeTimerBackground, distance: game.timeRemaining.progress(from: -0.2, to: 0))
        case (0)...(4.8):
            return .orangeTimerBackground
        case (4.8)...(5):
            return .lerp(from: .orangeTimerBackground, to: .white, distance: game.timeRemaining.progress(from: 4.8, to: 5))
        case (5)...(.infinity):
            return .white
        default:
            return .white
        }
    }
    
    var tintOpacity: Double {
        switch game.timeRemaining {
        case (-.infinity)...(-0.2): return 1
        case (-0.2)...(0): return .lerp(from: 1, to: 0.5, distance: game.timeRemaining.progress(from: -0.2, to: 0))
        case (0)...(5): return .lerp(from: 0.5, to: 0, distance: game.timeRemaining.progress(from: 0, to: 5))
        case (5)...(.infinity): return 0
        default: return 0
        }
    }
    
    var pauseColour: Color {
        game.isOvertime ?  .black : .blue
    }
}


fileprivate struct TimerText: View {
    enum TimerComponent { case minutes, colon, seconds }
    
    @EnvironmentObject private var game: TrackedGame
    
    init(for component: TimerComponent) {
        self.component = component
    }
    
    let component: TimerComponent
    
    var body: some View {
        Text(text)
            .font(.largeTitle)
            .fontWeight(.heavy)
            .animation(.none)
    }
            
    var text: String {
        switch component {
        case .minutes: return minutes
        case .colon: return ":"
        case .seconds: return seconds
        }
    }
    
    private var seconds: String {
        let secs = Int(abs(game.timeRemaining).rounded()) % 60
        return paddedString(from: secs)
    }
    
    private var minutes: String {
        let mins = Int(abs(game.timeRemaining).rounded() / 60)
        return paddedString(from: mins)
    }
    
    private func paddedString(from number: Int) -> String {
        switch number {
        case 0: return "00"
        case 1...9: return "0\(number)"
        default: return "\(number)"
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        AllSizes {
            TimerView()
                .environmentObject(TrackedGame(teamA: .empty, teamB: .empty, halfTime: 20))
        }
    }
}
