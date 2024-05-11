//
//  Card.swift
//  FlashZilla
//
//  Created by Asad Sayeed on 10/05/24.
//

import Foundation

struct Card: Codable {
    var prompt: String
    var answer: String
    
    static let example = Card(prompt: "Who played the 13th Doctor in Doctor who?", answer: "Jodie Whittaker")
}
