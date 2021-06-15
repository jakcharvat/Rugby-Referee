//
//  AllSizesPreviews.swift
//  Rugby Referee WatchKit Extension
//
//  Created by Jakub Charvat on 09.06.2021.
//

import SwiftUI


struct AllSizes<Content>: View where Content: View {
    @ViewBuilder
    let contentBuilder: () -> Content
    
    var body: some View {
        Group {
            contentBuilder()
                .previewDevice("Apple Watch Series 3 - 38mm")
            contentBuilder()
                .previewDevice("Apple Watch Series 6 - 44mm")
        }
    }
}
