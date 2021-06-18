//
//  GoalPicker.swift
//  Rugby Referee WatchKit Extension
//
//  Created by Jakub Charvat on 16.06.2021.
//

import SwiftUI

struct GoalPicker: View {
    init(then onPick: @escaping (Int) -> Void) {
        self.action = onPick
    }
    
    let action: (Int) -> Void
    
    var body: some View {
        List {
            scoreButton("Try", score: 5)
            scoreButton("Conversion", score: 2)
            scoreButton("Penalty / Drop", score: 3)
            scoreButton("Penalty Try", score: 7)
        }
    }
    
    @ViewBuilder
    func scoreButton(_ label: String, score: Int) -> some View {
        Button {
            action(score)
        } label: {
            HStack(spacing: 0) {
                Text(label)
                    .font(.caption2)
                    .fontWeight(.bold)
                
                Spacer(minLength: 4)
            
                Text("\(score)")
                    .font(.caption2)
                    .foregroundColor(.secondary)
                    .fontWeight(.heavy)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct GoalPicker_Previews: PreviewProvider {
    static var previews: some View {
        AllSizes {
            GoalPicker { _ in }
        }
    }
}
