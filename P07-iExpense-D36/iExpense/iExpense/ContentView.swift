//
//  ContentView.swift
//  iExpense
//
//  Created by Asad Sayeed on 14/12/23.
//
import Observation
import SwiftUI

// P12-C1: Start by upgrading it to use SwiftData.
// P12-C2: Add a customizable sort order option: by name or by amount.
// P12-C3: Add a filter option to show all expenses, just personal expenses, or just business expenses.
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
            // P15-C2: Fix the list rows in iExpense so they read out the name and value in one single VoiceOver label, and their type in a hint.
            .accessibilityLabel(item.name + item.type)

            Spacer()

            // P7-C1: Use the user’s preferred currency, rather than always using US dollars.
            Text(item.amount, format: .currency (code: Locale.current.currency?.identifier ?? "USD"))
            // P7-C2: Modify the expense amounts in ContentView to contain some styling depending on their value – expenses under $10 should have one style, expenses under $100 another, and expenses over $100 a third style. What those styles are depend on you.
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
    
    // P9-C2: Try changing project 7 so that it lets users edit their issue name in the navigation title rather than a separate textfield. Which option do you prefer?
    @State private var title = "iExpense"
    
    
    var body: some View {
        NavigationStack {
            // P7-C3: For a bigger challenge, try splitting the expenses list into two sections: one for personal expenses, and one for business expenses. This is tricky for a few reasons, not least because it means being careful about how items are deleted!
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
            .navigationTitle($title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // P9-C1: Change project 7 (iExpense) so that it uses NavigationLink for adding new expenses rather than a sheet. (Tip: The dismiss() code works great here, but you might want to add the navigationBarBackButtonHidden() modifier so they have to explicitly choose Cancel.)
                NavigationLink(destination: AddView(expenses: expenses)) {
                    Image(systemName: "plus")
                }
//                Button("Add Expense", systemImage: "plus") {
//                    showingAddExpense = true
//                }
            }
//            .sheet(isPresented: $showingAddExpense, content: {
//                AddView(expenses: expenses)
//            })
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
