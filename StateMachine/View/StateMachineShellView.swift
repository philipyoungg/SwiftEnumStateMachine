//
//  StateMachineShellView.swift
//  StateMachine
//
//  Created by Philip Young on 2024-06-01.
//

import Foundation
import SwiftUI

@MainActor
struct ViewShell<T: Equatable, U: View>: View {
    var vm: StatefulViewModel<T>
    var mainView: U
    
    init(vm: StatefulViewModel<T>, mainView: U) {
        self.vm = vm
        self.mainView = mainView
    }
    
    var body: some View {
        VStack(spacing: 40) {
            switch vm.state {
            case .idle, .loaded:
                mainView
            case .loading:
                Spacer()
                loadingView
                Spacer()
            case .error(let error):
                Spacer()
                errorView(error)
                Spacer()
            }
        }
        .padding()
        .onAppear {
            self.vm.send(.fetch)
        }
    }
    
    var loadingView: some View {
        Text("Loading...")
    }
    
    func errorView(_ error: Error) -> some View {
        VStack {
            Text(error.localizedDescription)
            Button("Fetch", action: {
                vm.send(.fetch)
            })
        }
        
    }
}
