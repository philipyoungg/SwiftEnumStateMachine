//
//  PostViewModel.swift
//  StateMachine
//
//  Created by Philip Young on 2024-06-01.
//

import Foundation

@MainActor
class PostViewModel: StatefulViewModel<Post> {
    var fetcher: PostFetchable
    init(fetcher: PostFetchable) {
        self.fetcher = fetcher
        super.init(initialState: .idle, initialData: [])
    }
    
    override func effectHandler(_ effect: State.Effect) async {
        switch effect {
        case .fetchData:
            do {
                let posts = try await fetcher.fetch()
                self.data = posts
                let _ = self.state.transition(.fetchSuccess(posts))
            } catch {
                let _ = self.state.transition(.fetchFailed(error))
            }
        }
    }
}
