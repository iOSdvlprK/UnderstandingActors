//
//  ContentView.swift
//  LearnMainActor
//
//  Created by joe on 3/15/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var todoListVM = TodoListViewModel()
    
    var body: some View {
        List(todoListVM.todos, id: \.id) { todo in
            Text(todo.title)
        }
        .task {
            todoListVM.populateTodos()
        }
    }
}

#Preview {
    ContentView()
}
