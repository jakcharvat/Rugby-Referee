//
//  GoalCounter.swift
//  Rugby Referee WatchKit Extension
//
//  Created by Jakub Charvat on 15.06.2021.
//

import SwiftUI

struct GoalCounter: View {
    let team: Team
    @Binding var count: Int
    
    let holdTime: TimeInterval = 0.6
    
    @State private var holdDownStart: Date?
    @State private var timer: Timer?
    
    @State private var isHeldDown: Bool = false
    @State private var holdScale: Double = 1
    
    var body: some View {
        Button(action: {}) {
            VStack(spacing: 0) {
                Text(team.acronym)
                    .font(.caption2)
                    .fontWeight(.black)
                    .foregroundColor(.secondary)
                
                Text("\(count)")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(team.colour)
            }
        }
        .frame(maxWidth: .infinity)
        .highPriorityGesture(gesture)
        .scaleEffect(timer == nil ? 1.0 : 0.9)
        .scaleEffect(holdScale)
        .colorMultiply(Color.lerp(from: .white, to: team.colour, distance: progress()))
    }
    
    
    var gesture: some Gesture {
        DragGesture(minimumDistance: 0, coordinateSpace: .local)
            .onChanged { _ in
                updateTimer()
            }
            .onEnded { _ in
                withAnimation(springAnimation) {
                    isHeldDown = false
                    holdScale = 1.0
                }
                
                timer?.invalidate()
                timer = nil
                holdDownStart = nil
            }
    }
    
    func scale() -> Double {
        guard holdDownStart != nil else { return 1 }
        return 1 - progress()*0.1
    }
    
    func progress() -> Double {
        guard let holdDownStart = holdDownStart else { return 0 }
        let time = holdDownStart.distance(to: Date())
        let progress = max(0, min(1, time / holdTime))
        return -(progress - 1) * (progress - 1) + 1
    }
    
    var springAnimation: Animation {
        return .spring(response: 0.4, dampingFraction: 1, blendDuration: 0)
    }
    
    var jumpAnimation: Animation {
        return .spring(response: 0.2, dampingFraction: 0.14, blendDuration: 0)
    }
    
    func getTimer() -> Timer {
        Timer.scheduledTimer(withTimeInterval: 0.04, repeats: true) { timer in
            holdScale = scale()
            
            guard let holdDownStart = holdDownStart else { return }
            let time = holdDownStart.distance(to: Date())
            if time > holdTime {
                incrementScore()
            }
        }
    }
    
    func incrementScore() {
        timer?.invalidate()
        timer = nil
        holdDownStart = nil
        count += 1
        
        withAnimation(jumpAnimation) {
            holdScale = 1
        }
        
        WKInterfaceDevice.current().play(.directionUp)
    }
    
    
    func updateTimer() {
        guard !isHeldDown else { return }
        
        holdDownStart = Date()
        withAnimation(springAnimation) {
            isHeldDown = true
            timer = getTimer()
        }
    }
}


struct GoalCounter_Previews: PreviewProvider {
    static var previews: some View {
        GoalCounter(team: .sample1, count: .constant(0))
    }
}
