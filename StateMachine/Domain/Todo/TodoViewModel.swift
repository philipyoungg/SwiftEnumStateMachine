//
//  TodoViewModel.swift
//  StateMachine
//
//  Created by Philip Young on 2024-06-01.
//

import Foundation


@MainActor
class TodoViewModel: StatefulViewModel<Todo> {
    enum FetchStrategy: String, CaseIterable {
        case Typicode, Mock
        
        var fetcher: TodoFetchable {
            switch self {
            case .Typicode: TypicodeTodoFetcher()
            case .Mock: MockFetcher()
            }
        }
    }
    
    @Published var fetchStrategy: FetchStrategy {
        didSet {
            self.todoFetcher = fetchStrategy.fetcher
        }
    }
    var todoFetcher: TodoFetchable
    
    init(initialData: [Todo]) {
        self.fetchStrategy = .Typicode
        self.todoFetcher = FetchStrategy.Typicode.fetcher
        super.init(initialState: .idle, initialData: initialData)
    }
    
    override func effectHandler(_ effect: State.Effect) async {
        switch effect {
            case .fetchData:
            do {
                let data = try await self.todoFetcher.fetch()
                self.data = data
                let _ = self.state.transition(.fetchSuccess(data))
                
            } catch {
                let _ = self.state.transition(.fetchFailed(error))
            }
        }
    }
}
