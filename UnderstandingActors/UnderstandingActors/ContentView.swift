//
//  ContentView.swift
//  UnderstandingActors
//
//  Created by joe on 3/10/24.
//

import SwiftUI

struct Counter {
    var value: Int = 0
    
    mutating func increment() -> Int {
        value += 1
        return value
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Button {
                let counter = Counter()

                DispatchQueue.concurrentPerform(iterations: 100) { _ in
                    var counter = counter
                    print(counter.increment())
                }
            } label: {
                Text("Increment")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
