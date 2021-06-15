//
//  NumberPicker.swift
//  Rugby Referee WatchKit Extension
//
//  Created by Jakub Charvat on 14.06.2021.
//

import SwiftUI

//MARK: - Number Picker
struct NumberPicker: View {
    init(_ name: String, in range: ClosedRange<Int>, selection: Binding<Int>) {
        self.name = name
        self.range = range
        _currentValue = selection
    }
    
    let name: String
    let range: ClosedRange<Int>
    @Binding var currentValue: Int
    @State private var searchString = ""
    
    var body: some View {
        VStack(spacing: 2) {
            Picker(name, selection: $currentValue) {
                ForEach(filteredNumbers, id: \.self) { num in
                    FilteredTextView(num, searchText: searchString)
                }
            }
            .labelsHidden()
            .padding(.bottom, 2)
        
            ButtonRow {
                filterButton(7)
                filterButton(8)
                filterButton(9)
            }
            
            ButtonRow {
                filterButton(4)
                filterButton(5)
                filterButton(6)
            }
            
            ButtonRow {
                filterButton(1)
                filterButton(2)
                filterButton(3)
            }
            
            ButtonRow {
                spacerButton
                filterButton(0)
                backspaceButton
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Continue") {
                    
                }
            }
        }
    }
    
    var filteredNumbers: [Int] {
        if searchString.isEmpty {
            return Array(range)
        }
        
        return range
            .filter { num in
                return "\(num)".contains(searchString)
            }
    }
    
    //MARK: Filter Button
    @ViewBuilder
    func filterButton(_ number: Int) -> some View {
        FilterButton(number) {
            searchString += "\(number)"
        }
        .disabled(isDisabled(number))
    }

    //MARK: Spacer Button
    @ViewBuilder
    var spacerButton: some View {
        FilterButton(action: {}, label: { Spacer() })
            .disabled(true)
            .opacity(0)
            .accessibility(hidden: true)
    }

    //MARK: Backspace Button
    @ViewBuilder
    var backspaceButton: some View {
        FilterButton {
            guard !searchString.isEmpty else { return }
            searchString.removeLast()
        } label: {
            Image(systemName: "delete.left")
        }
    }
    
    func isDisabled(_ num: Int) -> Bool {
        guard let projectedSearch = Int("\(searchString)\(num)") else {
            return true
        }
        
        if num == 0 && searchString.isEmpty { return true }
        return !range.contains(projectedSearch)
    }
}


//MARK: - Filtered Text View
fileprivate struct FilteredTextView: View {
    init(_ number: Int, searchText: String) {
        text = FilteredTextView.components(from: "\(number)", highlightingFirst: searchText)
    }
    
    let text: Text
    
    var body: some View {
        text
    }
    
    static func components(from str: String, highlightingFirst search: String) -> Text {
        if search.isEmpty { return Text(str) }
        guard let match = str.range(of: search) else { return Text(str) }
        
        var texts: [Text] = []
        texts.reserveCapacity(3)
        if match.lowerBound != str.startIndex {
            texts.append(
                Text(str[..<match.lowerBound])
                    .foregroundColor(.secondary)
            )
        }
        
        texts.append(
            Text(str[match])
                .bold()
        )
        
        if match.upperBound != str.endIndex {
            texts.append(
                Text(str[match.upperBound...])
                    .foregroundColor(.secondary)
            )
        }
        
        return texts.reduce(Text(""), +)
    }
}


//MARK: - Button Row
fileprivate struct ButtonRow<Content>: View where Content: View {
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    let content: Content
    
    var body: some View {
        HStack(spacing: 2) {
            content
        }
    }
}


//MARK: - Filter Button
fileprivate struct FilterButton<Content>: View where Content: View {
    init(_ number: Int, action: @escaping () -> Void) where Content == Text {
        self.content = Text("\(number)")
        self.action = action
    }
    
    init(action: @escaping () -> Void, @ViewBuilder label: () -> Content) {
        self.content = label()
        self.action = action
    }
    
    let content: Content
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.gray.opacity(0.2))
                )
        }
        .buttonStyle(.plain)
    }
}


//MARK: - Previews
struct NumberPicker_Previews: PreviewProvider {
    static var previews: some View {
        AllSizes {
            NumberPicker("Number", in: 1...10, selection: .constant(1))
        }
    }
}
