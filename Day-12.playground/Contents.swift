//struct Barbecue {
//    var charcoalBricks = 20
//    mutating func addBricks(_ number: Int) {
//        charcoalBricks += number
//    }
//}
//var barbecue = Barbecue()
//barbecue.addBricks(4)


//Checkpoint-7
//Class hierarchy of Animal, Dog and Cat as subclasses, Corgi and Poodle as subclasses of Dog, Persian and Lion as subclasses of Cat

class Animal {
    var legs: Int = 4
    
    init(legs: Int) {
        self.legs = legs
    }
}

class Dog: Animal {
    func speak() {
        print("Baww Baww!!")
    }
}

class Cat: Animal {
    var isTame: Bool = false
    init(isTame: Bool) {
        self.isTame = isTame
        super.init(legs: 4)
    }
    func speak() {
        print("Meowww")
    }
}

class Corgi: Dog {
    override func speak() {
        print("Bawwwww from Corgi")
    }
}

class Poodle: Dog {
    override func speak() {
        print("Boooo from Poodle")
    }
}

class Persian: Cat {
    override func speak() {
        print("Meeeee (persian cat)")
    }
}

class Lion: Cat {
    override func speak() {
        print("Rooooarrrrrr! from the King! Lion!")
    }
}

let MyCat = Lion(isTame: true)
MyCat.speak()
