//Day 14 : Optionals

//var username: String? = "username"
//
//if let unwrappedName = username {
//    print("We got a user: \(unwrappedName)")
//} else {
//    print("The optional was empty.")
//}


func square(number: Int) -> Int {
    number * number
}

var number: Int? = 999

//if let unwrapNumer = number {
//    print(square(number: unwrapNumer))
//}
//else{
//    print("No value is stored")
//}
//
//if let number = number {
//    print(square(number: number))
//}
//else{
//    print("No value is stored")
//}

//
//struct Book {
//    let title: String
//    let author: String?
//}
//
//var book: Book? = nil
//let author = book?.author?.first?.uppercased() ?? "A"
//print(author)

func checkPoint9 (optionalArray: [Int]?) -> Int { return optionalArray?.randomElement() ?? Int.random(in: 1...100) }
