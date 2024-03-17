//
//  TodoListViewModel.swift
//  LearnMainActor
//
//  Created by joe on 3/15/24.
//

import Foundation

class TodoListViewModel: ObservableObject {
    @Published var todos: [TodoViewModel] = []
    
    func populateTodos() {
        do {
            guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos") else {
                throw NetworkError.badUrl
            }
            
            Webservice().getAllTodos(url: url) { result in
                switch result {
                case .success(let todos):
                    self.todos = todos.map(TodoViewModel.init)
                case .failure(let error):
                    print(error)
                }
            }
        } catch {
            print(error)
        }
    }
}

struct TodoViewModel {
    let todo: Todo
    
    var id: Int {
        todo.id
    }
    
    var title: String {
        todo.title
    }
    
    var completed: Bool {
        todo.completed
    }
}
