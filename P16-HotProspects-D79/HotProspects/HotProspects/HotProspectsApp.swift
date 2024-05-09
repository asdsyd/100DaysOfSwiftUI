//
//  HotProspectsApp.swift
//  HotProspects
//
//  Created by Asad Sayeed on 08/05/24.
//
import SwiftData
import SwiftUI

@main
struct HotProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)
    }
}
