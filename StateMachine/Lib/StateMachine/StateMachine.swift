//
//  StateMachine.swift
//  StateMachine
//
//  Created by Philip Young on 2024-06-01.
//

import Foundation

protocol StateMachine: Equatable {
    associatedtype Action
    associatedtype Effect
    mutating func throwingTransition(_ action: Action) throws -> [Effect]
}

extension StateMachine {
    func isValidTransition(_ action: Action) -> Bool {
        var copy = self
        return (try? copy.throwingTransition(action)) != nil
    }
    
    mutating func transition(_ action: Action) -> [Effect] {
        if let effects = try? self.throwingTransition(action) {
            return effects
        }
        
        return []
    }
}
