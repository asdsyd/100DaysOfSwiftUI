//
//  Order.swift
//  CupcakeCorner
//
//  Created by Asad Sayeed on 20/04/24.
//

import Foundation


@Observable
class Order: Codable {
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _addSprinkles = "addSprinkles"
        case _extraFrosting = "extraFrosting"
        case _name = "name"
        case _streetAddress = "streetAddress"
        case _zip = "zip"
        case _city = "city"
    }
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Blueberry Bloom Edition"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
//    var name = ""
//    var streetAddress = ""
//    var city = ""
//    var zip = ""
    
    // P10-C3: For a more challenging task, try updating the Order class so it saves data such as the user's delivery address to UserDefaults. This takes a little thinking, because @AppStorage won't work here, and you'll find getters and setters cause problems with Codable support. Can you find a middle ground?
    var name = UserDefaults.standard.string(forKey: "name") ?? "" {
        didSet {
            UserDefaults.standard.setValue(name, forKey: "name")
        }
    }
    
    var streetAddress = UserDefaults.standard.string(forKey: "streetAddress") ?? "" {
        didSet {
            UserDefaults.standard.setValue(streetAddress, forKey: "streetAddress")
        }
    }
    
    var city = UserDefaults.standard.string(forKey: "city") ?? "" {
        didSet {
            UserDefaults.standard.setValue(city, forKey: "city")
        }
    }
    
    var zip = UserDefaults.standard.string(forKey: "zip") ?? "" {
        didSet {
            UserDefaults.standard.setValue(zip, forKey: "zip")
        }
    }
    
    
    // P10-C1: Our address fields are currently considered valid if they contain anything, even if it’s just only whitespace. Improve the validation to make sure a string of pure whitespace is invalid.
    var hasValidAddress: Bool {
        if name.trimmingCharacters(in: .whitespaces).isEmpty || streetAddress.trimmingCharacters(in: .whitespaces).isEmpty || city.trimmingCharacters(in: .whitespaces).isEmpty || zip.trimmingCharacters(in: .whitespaces).isEmpty {
            return false
        }
        
        return true
    }
    
    var cost: Decimal {
        // $2 per cake
        var cost = Decimal(quantity) * 2
        
        // complicated cake cost more
        cost += Decimal(type) / 2
        
        // $1/cake for extra frosting
        if extraFrosting {
            cost += Decimal(quantity)
        }
        
        // $0.50/cake for sprinkles
        if addSprinkles {
            cost += Decimal(quantity) / 2
        }
        
        return cost
    }
}
