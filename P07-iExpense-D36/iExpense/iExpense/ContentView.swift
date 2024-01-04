//
//  ContentView.swift
//  iExpense
//
//  Created by Asad Sayeed on 14/12/23.
//
import Observation
import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

struct ExpenseRow: View {
    var item: ExpenseItem
    @Binding var expenses: Expenses

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                Text(item.type)
            }

            Spacer()

            Text(item.amount, format: .currency (code: Locale.current.currency?.identifier ?? "USD"))
                .foregroundColor(item.amount < 100 ? .green : item.amount < 1000 ? .blue : .red)
        }
    }
}



@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
    }
}

struct ContentView: View {
    @State private var expenses = Expenses()
    
    @State private var showingAddExpense = false
    
    @State private var selectedFilter = ["Personal", "Business", "All"]
    
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Personal"))
                {
                    ForEach(expenses.items.filter { $0.type == "Personal" })
                    { item in
                        ExpenseRow(item: item, expenses: $expenses)
                    }
                    .onDelete
                    { IndexSet in
                        removeItems(at: IndexSet, type: "Personal")
                    }
                }
                
                Section(header: Text("Business"))
                {
                    ForEach(expenses.items.filter { $0.type == "Business" })
                    { item in
                        ExpenseRow(item: item, expenses: $expenses)
                    }
                    .onDelete
                    { IndexSet in
                        removeItems(at: IndexSet, type: "Business")
                    }
                }
                
                
//                ForEach(expenses.items) { item in
//                    HStack {
//                        VStack(alignment: .leading) {
//                            Text(item.name)
//                                .font(.headline)
//                            
//                            Text(item.type)
//                        }
//                        
//                        Spacer()
//                        
//                        Text(item.amount, format:
//                                .currency(code: Locale.current.currency?.identifier ?? "USD"))
//                        .foregroundColor(item.amount < 100 ? .green : item.amount < 1000 ? .blue : .red)
//                    }
//                }
//                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense = true
                }
            }
            .sheet(isPresented: $showingAddExpense, content: {
                AddView(expenses: expenses)
            })
        }
    }
    
//    func removeItems(at offsets: IndexSet, type: String ) {
//        let filteredIndices = expenses.items.indices.filter { expenses.items[$0].type == type }
//        let indicesToRemove = offsets.map { filteredIndices[$0] }
//        expenses.items.remove(atOffsets: indicesToRemove)
////        expenses.items.remove(atOffsets: offsets)
//    }
    func removeItems(at offsets: IndexSet, type: String) {
        let itemsToRemove = expenses.items.enumerated().filter { $0.element.type == type }
        let indicesToRemove = offsets.map { itemsToRemove[$0].offset }

        for index in indicesToRemove.sorted(by: >) {
            expenses.items.remove(at: index)
        }
    }


}

#Preview {
    ContentView()
}
