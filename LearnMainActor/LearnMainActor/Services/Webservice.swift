//
//  Webservice.swift
//  LearnMainActor
//
//  Created by joe on 3/15/24.
//

import Foundation

enum NetworkError: Error {
    case badUrl
    case decodingError
    case badRequest
}

class Webservice {
    func getAllTodos(url: URL, completion: @MainActor @escaping (Result<[Todo], NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                Task {
                    await completion(.failure(.badRequest))
                }
                return
            }
            
            guard let todos = try? JSONDecoder().decode([Todo].self, from: data) else {
                Task {
                    await completion(.failure(.decodingError))
                }
                return
            }
            
            Task {
                await completion(.success(todos))
            }
        }.resume()
    }
}
