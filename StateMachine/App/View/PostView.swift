//
//  PostView.swift
//  StateMachine
//
//  Created by Philip Young on 2024-06-01.
//

import Foundation
import SwiftUI

struct PostView: View {
    @StateObject var vm: PostViewModel
    
    var body: some View {
        FetchMachineShellView(vm: vm, mainView: { posts in
            VStack(alignment: .leading, spacing: 40) {
                Button("Fetch") {
                    vm.send(.fetch)
                }
                List {
                    ForEach(posts, id: \.id) { post in
                        VStack(alignment: .leading) {
                            Text(post.title).bold()
                            Text(post.body).font(.footnote)
                        }
                    }
                }
            }
        })
    }
}
