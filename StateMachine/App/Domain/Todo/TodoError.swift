//
//  TodoError.swift
//  StateMachine
//
//  Created by Philip Young on 2024-06-01.
//

import Foundation



enum TodoError: Error, LocalizedError {
    case fetchFailed
    case unknownError
    
    var errorDescription: String? {
        switch self {
        case .fetchFailed: return "Data retrieval failed for unknown reason"
        case .unknownError: return "Unknown Error"
        }
    }
}
