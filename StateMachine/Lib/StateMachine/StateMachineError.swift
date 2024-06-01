//
//  StateMachineError.swift
//  StateMachine
//
//  Created by Philip Young on 2024-06-01.
//

import Foundation

enum StateMachineError: LocalizedError {
    case invalidTransition
    
    var errorDescription: String? {
        switch self {
        case .invalidTransition: return "Invalid transition"
        }
    }
}
