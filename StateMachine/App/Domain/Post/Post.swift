//
//  Post.swift
//  StateMachine
//
//  Created by Philip Young on 2024-06-01.
//

import Foundation

struct Post: Equatable, Decodable {
    var id: Int
    var title: String
    var body: String
}
