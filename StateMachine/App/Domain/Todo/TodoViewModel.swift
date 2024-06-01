//
//  TodoViewModel.swift
//  StateMachine
//
//  Created by Philip Young on 2024-06-01.
//

import Foundation


@MainActor
class TodoViewModel: FetchMachineViewModel<Todo> {
    enum FetchStrategy: String, CaseIterable {
        case Typicode, Mock
        
        var fetcher: TodoRepository {
            switch self {
            case .Typicode: TypicodeTodoRepository()
            case .Mock: MockFetcher()
            }
        }
    }
    
    @Published var fetchStrategy: FetchStrategy {
        didSet {
            self.todoFetcher = fetchStrategy.fetcher
        }
    }
    var todoFetcher: TodoRepository
    
    init(fetchStrategy: FetchStrategy = .Typicode) {
        self.fetchStrategy = fetchStrategy
        self.todoFetcher = fetchStrategy.fetcher
        super.init(initialState: .idle)
    }
    
    override func effectHandler(_ effect: State.Effect) async {
        switch effect {
            case .fetchData:
            do {
                let todo = try await self.todoFetcher.getTodos()
                let _ = self.state.transition(.fetchSuccess(todo))
                
            } catch {
                let _ = self.state.transition(.fetchFailed(error))
            }
        }
    }
}
