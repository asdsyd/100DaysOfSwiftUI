import UIKit

//var greeting = "Hello, playground"
// 
//let str = "String here"
//
//let album: String = "Reputation"
//
//let switchkey: Bool
//
//let ringo = "Ringo starr"
//let ango = "John Ango"
//
//let beatles = [ringo, ango]
//
//beatles[0]
//beatles[1]
//
//let colors = Set(["red", "green", "blue"])
//let colors2 = Set(["red", "green", "blue", "pink", "blue"])
//
//
//var groceryList = Set<String>(["Apple", "Orange"])
//
//print(groceryList)
//
//


// Swift Programming: The Big Nerd Ranch Guide
//2. Types, Constants and Variables


//var lastName: String = "Sayeed"
//
//print(lastName)

//var numberOfStoplights: String = "4" //-> This is called type annotation syntax
//numberOfStoplights += "5"
//
//let numberOfStopligths: Int = 4
//var population: Int
//population = 5422
//let townName: String = "Hyderabad"
//let townElevation: Double = 4_000
//let townDescription: String = "\(townName) has a population of \(population) and \(numberOfStopligths) stoplights. This town has an elevation of \(townElevation) kms."


//8 Arrays

let john = "John Lennon"
let paul = "Paul McCartney"
let george = "George Harrison"
let ringo = "Ringo Starr"

let beatles = [john, paul, george, ringo]

let myArray: [Double]
let myArray2: [Int]

//Sets

let colors = Set(["red", "green", "blue"])

//Tuples
var name = (first: "Taylor", last: "Swift")
name.first
name.0

//Arrays vs Tuples vs Sets

let address = (house: 555, street: "Taylor Swift", city: "Nashville")

//Dictionaries

let heights = [
    "Taylor Swift": 1.78,
    "Ed Sheeeran": 1.73
]


let book:[String: Bool]
book = ["Old": true]

book["Old"]

//Creating empty collections
var teams = [String: String]()
teams["Oool"] = "Red"

var results = [Int]()

var words = Set<String>()
var numbers = Set<Int>()
var numbers2: Set<Int>
numbers2 = Set([3,4,5,5])
numbers2.contains(3)

//enumerations
let result = "failure"
let result2 = "failed"
let result3 = "fail"

enum Result {
    case success
    case failure
}

let result4 = Result.failure

enum Activity {
    case bored
    case running(destination: String)
    case talking(topic: String)
    case singing(volume: Int)
}

let talking = Activity.talking(topic: "football")

enum Planet: Int {
    case mercury = 1
    case venus
    case earth
    case mars
}

let earth = Planet(rawValue: 3)

//Arrays, sets, tuples, and dictionaries let you store a group of items under a single value. They each do this in different ways, so which you use depends on the behaviour you want. 





















