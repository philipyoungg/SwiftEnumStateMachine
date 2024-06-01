//
//  StatefulViewModel.swift
//  StateMachine
//
//  Created by Philip Young on 2024-06-01.
//

import Foundation

@MainActor
class StatefulViewModel<T: Equatable>: ObservableObject {
    typealias State = FetchStateMachine<T>
    @Published var state: State
    @Published var data: [T]
    
    var tasks: [Task<Void, Never>] = []
    
    init(initialState: State, initialData: [T]) {
        self.state = initialState
        self.data = initialData
    }
    
    deinit { tasks.forEach { $0.cancel() } }
    
    func handle(_ effects: [State.Effect], using handler: @escaping (State.Effect) async -> Void) {
        effects.forEach { effect in
            tasks.append(Task { await handler(effect) })
        }
    }
    
    func send(_ action: State.Action) {
        let effects = self.state.transition(action)
        handle(effects, using: effectHandler)
    }
    
    func effectHandler(_ effect: State.Effect) async {
        print("Not handled")
    }
}
