//FizzBuzz Ver.Using Extension
extension Int{
    
    func fizzbuzz()->String{
        if self % 15 == 0{
            return "FizzBuzz"
        }
        else if self % 3 == 0{
            return "Fizz"
        }
        else if self % 5 == 0{
            return "Buzz"
        }
        else{
            return String(self)
        }
    }
}

for n in 1...100{
    print(n.fizzbuzz())
}
