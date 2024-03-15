//
//  Todo.swift
//  LearnMainActor
//
//  Created by joe on 3/15/24.
//

import Foundation

struct Todo: Decodable {
    let id: Int
    let title: String
    let completed: Bool
}
