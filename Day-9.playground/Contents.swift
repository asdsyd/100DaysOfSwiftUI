import Cocoa

//How to create and use closures
//func greetUser() {
//    print("Hi there!")
//}
//
//greetUser()
//var greetCopy = greetUser()
//greetCopy()
//
//let sayHello = { (name: String) -> String in
//    "hi \(name)"
//}
//
//sayHello

//
//func greetUser() {
//    print("hi there")
//}
//
//var greetCopy: () -> Void = greetUser

//CheckPoint 5
let luckyNumbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]

luckyNumbers.filter({!$0.isMultiple(of: 2)}).sorted().map({print("\($0) is lucky no.")})
