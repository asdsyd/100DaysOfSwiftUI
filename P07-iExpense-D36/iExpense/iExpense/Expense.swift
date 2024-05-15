//
//  Expense.swift
//  iExpense
//
//  Created by Asad Sayeed on 14/05/24.
//

import Foundation
import SwiftData

@Model
class Expense {
    var items = [ExpenseItem]()
    
    init(items: [ExpenseItem] = [ExpenseItem]()) {
        self.items = items
    }
}
