//
//  PostFetchable.swift
//  StateMachine
//
//  Created by Philip Young on 2024-06-01.
//

import Foundation

protocol PostRepository {
    func fetch() async throws -> [Post]
}

class TypicodePostRepository: PostRepository {
    func fetch() async throws -> [Post] {
        let (data, response) =  try await URLSession.shared.data(from: .init(string: "https://jsonplaceholder.typicode.com/posts")!)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        do {
            let decoder = JSONDecoder()
            let posts = try decoder.decode([Post].self, from: data)
            return posts
        } catch {
            throw error
        }
    }
}
