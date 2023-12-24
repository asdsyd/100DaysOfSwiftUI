//PROTOCOLS AND EXTENSIONS
import Cocoa

//protocol Vehicle {
//    func estimateTime(for distance: Int) -> Int
//    func travel(distance: Int)
//}
//
//
////This means that the below struct must implement both func of the above protocol.
//struct Car: Vehicle {
//    func estimateTime(for distance: Int) -> Int {
//        distance / 50
//    }
//    
//    func travel(distance: Int) {
//        print("I'm drinving \(distance) km")
//    }
//}


//Checkpoint 8

protocol Building {
    var room: Int { get }
    var buildingCost: Int { get }
    var estateAgent: String { get set }
    var name: Building.Type { get }
    func SalesSummary()
}

extension Building {
    func SalesSummary() {
        print("Sales summary for the \(name) ")
    }
}


struct House: Building {
    var name: Building.Type
    
    
    var room: Int
    var buildingCost: Int
    var estateAgent: String
    
}

struct Office: Building {
    var name: Building.Type
    
    var room: Int
    var buildingCost: Int
    var estateAgent: String
    
    
}

let office = Office(name: Office.self, room: 4, buildingCost: 2000, estateAgent: "Arbaz")

let house = House(name: House.self, room: 2, buildingCost: 100, estateAgent: "Hisham")

office.SalesSummary()
house.SalesSummary()
