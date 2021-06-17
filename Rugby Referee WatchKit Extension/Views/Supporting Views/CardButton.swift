//
//  CardButton.swift
//  Rugby Referee WatchKit Extension
//
//  Created by Jakub Charvat on 17.06.2021.
//

import SwiftUI

struct CardButton: View {
    init(_ card: Card, isOpen: Binding<Bool>) {
        self.card = card
        _isOpen = isOpen
    }
    
    let card: Card
    @Binding var isOpen: Bool
    
    var body: some View {
        Button {
            isOpen = true
        } label: {
            Image(systemName: "rectangle.fill.on.rectangle.angled.fill")
                .rotationEffect(.degrees(270))
                .font(.largeTitle)
                .foregroundColor(card.colour)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct CardButton_Previews: PreviewProvider {
    static var previews: some View {
        CardButton(.red, isOpen: .constant(false))
    }
}
