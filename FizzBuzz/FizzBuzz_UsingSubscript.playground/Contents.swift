//FizzBuzz Ver.Using Subscript
class FizzBuzz{
    
    subscript(index: Int)-> String{
        if index % 15 == 0{
            return "FizzBuzz"
        }
        else if index % 3 == 0{
            return "Fizz"
        }
        else if index % 5 == 0{
            return "Buzz"
        }
        else{
            return String(index)
        }
    }
}

let fizzbuzz = FizzBuzz()
for n in 1...100{
    print(fizzbuzz[n])
}
