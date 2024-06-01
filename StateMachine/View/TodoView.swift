//
//  TodoView.swift
//  StateMachine
//
//  Created by Philip Young on 2024-06-01.
//

import Foundation
import SwiftUI

struct TodoView: View {
    @StateObject var vm: TodoViewModel
    
    var body: some View {
        FetchMachineShellView(vm: vm, mainView: mainView)
    }
    
    var strategyPicker: some View {
        Picker("Strategy", selection: $vm.fetchStrategy) {
            ForEach(TodoViewModel.FetchStrategy.allCases, id: \.self) {
                Text($0.rawValue)
            }
        }.pickerStyle(SegmentedPickerStyle())
    }
    
    var mainView: some View {
        VStack(alignment: .leading, spacing: 40) {
            strategyPicker
            self.todoRenderer(todos: vm.data)
            Button("Fetch", action: {
                vm.send(.fetch)
            })
        }
    }
    
    var loadingView: some View {
        Text("Loading...")
    }
    
    func errorView(_ error: Error) -> some View {
        VStack {
            Text(error.localizedDescription)
            Button("Fetch", action: {
                vm.send(.fetch)
            })
        }
        
    }
    
    @ViewBuilder
    func todoRenderer(todos: [Todo]) -> some View {
        List {
            ForEach(todos) { todo in
                HStack(spacing: 4) {
                    Circle().frame(width: 12, height: 12)
                    Text(todo.title).padding(4)
                }
            }
        }
    }
}
