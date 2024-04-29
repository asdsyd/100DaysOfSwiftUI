//
//  Location.swift
//  BucketList
//
//  Created by Asad Sayeed on 28/04/24.
//

import Foundation
import MapKit

struct Location: Codable, Equatable, Identifiable {
    var id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    #if DEBUG
    static let example = Location(id: UUID(), name: "Falaknuma Palace", description: "Having the world's largest table", latitude: 17.3, longitude: 78.4)
    #endif
    
    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
