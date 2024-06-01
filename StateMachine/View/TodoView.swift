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
    
    func mainView(todos: [Todo]) -> some View {
        VStack(alignment: .leading, spacing: 40) {
            strategyPicker
            Button("Fetch", action: {
                vm.send(.fetch)
            })
            self.todoRenderer(todos: todos)
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
