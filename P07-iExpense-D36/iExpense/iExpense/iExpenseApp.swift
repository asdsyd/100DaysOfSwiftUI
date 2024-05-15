//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Asad Sayeed on 14/12/23.
//

import SwiftData
import SwiftUI

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [ExpenseItem.self])
        }
    }
}
