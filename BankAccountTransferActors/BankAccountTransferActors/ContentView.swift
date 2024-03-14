//
//  ContentView.swift
//  BankAccountTransferActors
//
//  Created by joe on 3/13/24.
//

import SwiftUI

enum BankError: Error {
    case insufficientFunds(Double)
}

actor BankAccount {
    let accountNumber: Int
    var balance: Double
    
    init(accountNumber: Int, balance: Double) {
        self.accountNumber = accountNumber
        self.balance = balance
    }
    
    nonisolated func getCurrentAPR() -> Double {
        return 0.2
    }
    
    func deposit(_ amount: Double) {
        balance += amount
    }
    
    func transfer(amount: Double, to other: BankAccount) async throws {
        if amount > balance {
            throw BankError.insufficientFunds(amount)
        }
        
        balance -= amount
        await other.deposit(amount)
        
        print("Current Account: \(balance), Other Account: \(await other.balance)")
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Button {
                let bankAccount = BankAccount(accountNumber: 123, balance: 500)
                let otherAccount = BankAccount(accountNumber: 456, balance: 100)
                
                let _ = bankAccount.getCurrentAPR() // calling nonisolated function
                
                DispatchQueue.concurrentPerform(iterations: 100) { _ in
                    Task {
                        try? await bankAccount.transfer(amount: 300, to: otherAccount)
                    }
                }
            } label: {
                Text("Transfer")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
