//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Asad Sayeed on 16/05/24.
//

import SwiftUI

@Observable
class Favorites {
    private var resorts: Set<String>
    private let key = "Favorites"
    
    init() {
        resorts = []
        load()
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        resorts.insert(resort.id)
    }
    
    func remove(_ resort: Resort) {
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        // P19-C2: Fill in the loading and saving methods for Favorites.
        // write out all data
        do {
            let encoded = try JSONEncoder().encode(resorts)
            UserDefaults.standard.set(encoded, forKey: key)
        } catch {
            print("Failed to save resorts: \(error.localizedDescription)")
        }
    }
    
    func load() {
        // load all data
        if let savedResorts = UserDefaults.standard.data(forKey: key) {
            do {
                resorts = try JSONDecoder().decode(Set<String>.self, from: savedResorts)
            } catch {
                print("Failed to load resorts: \(error.localizedDescription)")
            }
        }
    }
}
