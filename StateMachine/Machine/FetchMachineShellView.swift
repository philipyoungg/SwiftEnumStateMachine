//
//  StateMachineShellView.swift
//  StateMachine
//
//  Created by Philip Young on 2024-06-01.
//

import Foundation
import SwiftUI

struct FetchMachineShellView<T: Equatable, U: View>: View {
    @ObservedObject var vm: FetchMachineViewModel<T>
    var mainView: ([T]) -> U
    
    init(vm: FetchMachineViewModel<T>, mainView: @escaping ([T]) -> U) {
        self.vm = vm
        self.mainView = mainView
    }
    
    var body: some View {
        VStack(spacing: 40) {
            switch vm.state {
            case .loaded(let data):
                self.mainView(data)
            case .idle, .loading:
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
