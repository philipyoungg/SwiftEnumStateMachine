//
//  TodoFetchable.swift
//  StateMachine
//
//  Created by Philip Young on 2024-06-01.
//

import Foundation

protocol TodoRepository {
    func getTodos() async throws -> [Todo]
}

class TypicodeTodoRepository: TodoRepository {
    func getTodos() async throws -> [Todo] {
        let (data, response) =  try await URLSession.shared.data(from: .init(string: "https://jsonplaceholder.typicode.com/todos")!)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        do {
            let decoder = JSONDecoder()
            let todos = try decoder.decode([Todo].self, from: data)
            return todos
        } catch {
            throw error
        }
    }
}

let MOCK_TODOS: [Todo] = [.init(id: 0, title: "Henlo world"), .init(id: 1, title: "Another")]

class MockFetcher: TodoRepository {
    func getTodos() async throws -> [Todo] {
        try await Task.sleep(nanoseconds: 500_000_000)
        if Double.random(in: 0...1) > 0.5 {
            return MOCK_TODOS
        }
        throw TodoError.fetchFailed
    }
}
