//
//  StringIsEmpty.swift
//  Bookworm
//
//  Created by Asad Sayeed on 03/05/24.
//
// P11-C1: Right now it’s possible to select no title, author, or genre for books, which causes a problem for the detail view. Please fix this, either by forcing defaults, validating the form, or showing a default picture for unknown genres – you can choose.

import Foundation
extension String {
    var isReallyEmpty: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
