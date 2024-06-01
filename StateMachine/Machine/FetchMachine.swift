//
//  FetchMachine.swift
//  StateMachine
//
//  Created by Philip Young on 2024-06-01.
//

import Foundation

enum FetchStateMachine<T: Equatable>: StateMachine {
    static func == (lhs: FetchStateMachine, rhs: FetchStateMachine) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle), (.loading, .loading), (.error, error):
            return true
        case (.loaded(let lData), .loaded(let rData)):
            return lData == rData
        default:
            return false
        }
    }
    
    case idle
    case loading
    case loaded([T])
    case error(Error)
    
    
    enum Action {
        case fetch
        case fetchSuccess([T])
        case fetchFailed(Error)
    }
    
    enum Effect {
        case fetchData
    }
    
    internal mutating func throwingTransition(_ action: Action) throws -> [Effect] {
        switch (self, action) {
        case (.idle, .fetch), (.loaded, .fetch), (.error, .fetch):
            self = .loading
            return [.fetchData]
        case (.loading, .fetchSuccess(let data)):
            self = .loaded(data)
            return []
        case (.loading, .fetchFailed(let error)):
            self = .error(error)
            return []
        default:
            throw StateMachineError.invalidTransition
        }
    }
}
