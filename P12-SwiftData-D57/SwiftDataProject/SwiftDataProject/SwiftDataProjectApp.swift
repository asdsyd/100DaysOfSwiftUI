//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Asad Sayeed on 13/05/24.
//

import SwiftData
import SwiftUI

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
