import Cocoa

//var greeting = "Hello, playground"
//
////How to provide default values for parameters
////printTimesTables
//func printTimesTables(_ number: Int, end: Int = 10) {
//    for i in 1...end {
//        print("\(i) x \(number) is \(i*number)")
//    }
//}
//
//printTimesTables(5, end: 20)
//printTimesTables(8)


//how to handle errors in functions
//3 step process
////step 1 define the problems that can occur
//enum PasswordError: Error {
//    case short, obvious
//}
////step 2 is to write a func that will trigger when error occurs
//func checkPassword(_ password: String) throws -> String {
//    if password.count < 5 { throw PasswordError.short }
//    if password == "12345" { throw PasswordError.obvious }
//    
//    if password.count < 8 {
//        return "OK"
//    } else if password.count < 10 {
//        return "Good"
//    } else {
//        return "Excellent"
//    }
//}
//
//let string = "23"
//
//do {
//    let result = try  checkPassword(string)
//    print("Password rating: \(result)")
//    //} catch PasswordError.short {
//    //    print("Please use a lonnger password.")
//    //} catch PasswordError.obvious{
//    //    print("Easily guessed password. Choose another!")
//    //} catch {
//    //    print("There was an error.")
//    //}
//} catch {
//    print("There was an error: \(error.localizedDescription)")
//}


//Checkpoint: 4
//Write a function that accepts an integer from 1 through 10,000 and returns
//the integer square root of that number...
enum integerError: Error {
    case outOfBound, noRoot
}


func integerSquareRoot (_ number: Int) throws -> Int {
    let number = number
    if number < 1 || number > 10_000 {
        throw integerError.outOfBound
    }
    
    for i in 1...100 {
        if i*i == number {
            return i
        }
    }
    
    throw integerError.noRoot
}

do {
    let result = try integerSquareRoot(89)
    print("Result is: \(result)")
} catch integerError.noRoot {
    print("No root exisits for the number.")
} catch integerError.outOfBound {
    print("Out of bound.")
} catch {
    print("There was an error. \(error.localizedDescription)")
}

