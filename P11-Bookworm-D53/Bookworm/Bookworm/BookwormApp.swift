//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Asad Sayeed on 21/04/24.
//
import SwiftData
import SwiftUI

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
