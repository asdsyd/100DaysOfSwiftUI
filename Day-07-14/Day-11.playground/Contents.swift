import Cocoa

//create a struct to store info about a car
//model, no of seats, current gear
//change gear up down method
//use access control

struct Car {
    var name: String = "default name"
    var model: String = "default model"
    var seats: Int = 2
    let gears: Int
    var currentGear: Int = 0
    
    init(name: String, model: String, seats: Int, gears: Int, currentGear: Int) {
        self.name = name
        self.model = model
        self.seats = seats
        self.gears = gears
        self.currentGear = currentGear
    }
    
    mutating func changeGear (to newGear: Int) -> Void {
        if newGear > 0 && newGear <= gears {
            self.currentGear = newGear
        }
        else {
            print("Error changing gears")
        }
        
    }
    
}

var NewCar = Car(name: "Tesla", model: "X", seats: 4, gears: 5, currentGear: 1)

NewCar.changeGear(to: 5)
NewCar.changeGear(to: 7)
