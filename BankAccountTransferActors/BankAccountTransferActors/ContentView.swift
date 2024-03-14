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

class BankAccount {
    let accountNumber: Int
    var balance: Double
    
    init(accountNumber: Int, balance: Double) {
        self.accountNumber = accountNumber
        self.balance = balance
    }
    
    func transfer(amount: Double, to other: BankAccount) throws {
        if amount > balance {
            throw BankError.insufficientFunds(amount)
        }
        
        balance -= amount
        other.balance += amount
        
        print("Current Account: \(balance), Other Account: \(other.balance)")
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Button {
                let bankAccount = BankAccount(accountNumber: 123, balance: 500)
                let otherAccount = BankAccount(accountNumber: 456, balance: 100)
                
                DispatchQueue.concurrentPerform(iterations: 100) { _ in
                    try? bankAccount.transfer(amount: 300, to: otherAccount)
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
