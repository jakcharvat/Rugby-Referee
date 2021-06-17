//
//  CardSelectionScreen.swift
//  Rugby Referee WatchKit Extension
//
//  Created by Jakub Charvat on 17.06.2021.
//

import SwiftUI

struct CardSelectionScreen: View {
    let team: Team
    
    @State private var openedCard: Card?
    
    var body: some View {
        VStack {
            Text(team.acronym)
                .font(.largeTitle)
                .fontWeight(.bold)
            HStack {
                CardButton(.yellow, isOpen: .constant(false))
                CardButton(.red, isOpen: .constant(false))
            }
        }
    }
}

struct CardSelectionScreen_Previews: PreviewProvider {
    static var previews: some View {
        CardSelectionScreen(team: .sample1)
    }
}
