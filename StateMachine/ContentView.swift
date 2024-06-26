//
//  ContentView.swift
//  StateMachine
//
//  Created by Philip Young on 2024-06-01.
//

import SwiftUI

struct ContentView: View {
    enum Page: String, CaseIterable {
        case Todo, Post
    }
    @State var page: Page = .Post
    var body: some View {
        Picker("Page", selection: self.$page) {
            ForEach(Page.allCases, id: \.self) {
                Text($0.rawValue)
            }
        }.pickerStyle(SegmentedPickerStyle())
        switch self.page {
        case .Todo:
            TodoView(vm: TodoViewModel(fetchStrategy: .Mock))
        case .Post:
            PostView(vm: PostViewModel(fetcher: TypicodePostRepository()))
        }
    }
}

#Preview {
    ContentView()
        .frame(width: 400, height: 600)
}
