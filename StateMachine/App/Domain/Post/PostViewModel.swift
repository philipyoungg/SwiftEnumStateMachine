//
//  PostViewModel.swift
//  StateMachine
//
//  Created by Philip Young on 2024-06-01.
//

import Foundation

@MainActor
class PostViewModel: FetchMachineViewModel<Post> {
    var fetcher: PostRepository
    init(fetcher: PostRepository) {
        self.fetcher = fetcher
        super.init(initialState: .idle)
    }
    
    override func effectHandler(_ effect: State.Effect) async {
        switch effect {
        case .fetchData:
            do {
                let posts = try await fetcher.fetch()
                let _ = self.state.transition(.fetchSuccess(posts))
            } catch {
                let _ = self.state.transition(.fetchFailed(error))
            }
        }
    }
}
