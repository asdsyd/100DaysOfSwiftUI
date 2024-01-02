import Cocoa

//let root = sqrt(169)
//
//print(root)


//func rollDice() -> Int {
//    return Int.random(in: 1...6)
//}
//
//print(rollDice())

//
//func checkTwoStringsForSameLetters(stringA: String, stringB: String) -> Bool {
//    stringA.sorted() == stringB.sorted()
////    if stringA.sorted() == stringB.sorted() {
////        return true
////    } else {
////        return false
////    }
//}
//checkTwoStringsForSameLetters(stringA: "sssa", stringB: "asss")
//print(checkTwoStringsForSameLetters(stringA: "abc", stringB: "cab"))
//print("testing")


//How to return multiple values from functions
//func getUser2() -> (String, String) {
//    ("Asad", "Sayeed")
//}
//
//let user2 = getUser2()
//print("Name: \(user2.0) \(user2.1)")


//How to customize parameter labels

//
////function with 2 parameters that returns an Int
//func sum (a: Int, b: Int) -> Int {
//    a - b
//}
//let answer = sum(a: 5, b: 10)
//print(answer)
//
////the closure equivalent
////Questions
////Why closure? How is it better than functions? What's the difference between function and closure ?
////Why closure because it is more readable and code conscise. And that's the difference. It is used a lot more due to this
//
////The closure equivalent
//let sumClosure: (Int, Int) -> Int = { (a, b) in
//        a + b
//    }
//let closureAnswer = sumClosure(9, 5)
//print(closureAnswer)

//Closure as Function Parameters
func sayHello (to name: String, finallySayIt: (String) -> ()) {
    let newName = name.uppercased()
    finallySayIt(newName)
}

////Option-1
sayHello(to: "Asad", finallySayIt: {name3 in
        print("Hi \(name3)")
})

//Option-2 also called as The trailing closure
sayHello(to: "Asad") { name in
    print("Hello \(name)")
}

//Option-3
let reallySayIt: (String) -> () = { name in
        print("Hello \(name)")
}
sayHello(to: "Asad", finallySayIt: reallySayIt)



