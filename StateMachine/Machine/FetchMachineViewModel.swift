//
//  StatefulViewModel.swift
//  StateMachine
//
//  Created by Philip Young on 2024-06-01.
//

import Foundation

@MainActor
class FetchMachineViewModel<T: Equatable>: ObservableObject {
    typealias State = FetchStateMachine<T>
    @Published var state: State
    @Published var data: [T]
    
    var tasks: [Task<Void, Never>] = []
    
    init(initialState: State, initialData: [T]) {
        self.state = initialState
        self.data = initialData
    }
    
    deinit { tasks.forEach { $0.cancel() } }
    
    func send(_ action: State.Action) {
        let effects = self.state.transition(action)
        effects.forEach { effect in
            tasks.append(Task { await effectHandler(effect) })
        }
    }
    
    func effectHandler(_ effect: State.Effect) async {
        print("Not handled")
    }
}
