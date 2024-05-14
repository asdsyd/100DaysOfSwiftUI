//
//  Job.swift
//  SwiftDataProject
//
//  Created by Asad Sayeed on 14/05/24.
//

import Foundation
import SwiftData

@Model
class Job {
    var name: String
    var priority: Int
    var ownwer: User?
    
    init(name: String, priority: Int, ownwer: User? = nil) {
        self.name = name
        self.priority = priority
        self.ownwer = ownwer
    }
    
}
