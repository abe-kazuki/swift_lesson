//FizzBuzz Ver.Using Function
func fizzbuzz(number: Int)->String{
    if number % 15 == 0{
        return "FizzBuzz"
    }
    else if number % 3 == 0{
        return "Fizz"
    }
    else if number % 5 == 0{
        return "Buzz"
    }
    else{
        return String(number)
    }
}

for n in 1...100{
    print(fizzbuzz(number: n))
}
