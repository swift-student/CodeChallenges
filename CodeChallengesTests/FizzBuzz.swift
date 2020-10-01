//
//  FizzBuzz.swift
//  CodeChallengesTests
//
//  Created by Shawn Gee on 8/6/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import XCTest

// MARK: - Challenge
    
//Fizz Buzz

//Write a function that counts from 1 through 100, and prints "Fizz" if the counter is evenly divisible by 3, "Buzz" if it's evenly divisible by 5, "Fizz Buzz" if it's even divisible by three and five, or the counter number for all other cases.

//Sample input and output
//• 1 should print "1"
//• 2 should print "2"
//• 3 should print "Fizz"
//• 4 should print "4"
//• 5 should print "Buzz"
//• 15 should print "Fizz Buzz"

//Hint #1: You'll need to use modulus: %.
//Hint #2: Check for the "Fizz Buzz" case first, because that's most specific.
//Hint #3: Remember to use the closed range operator to include the number 100 at the end. 1...100
    
// MARK: - Plan

// Make a for loop that counts from 1 to 100
// Switch on whether counter is evenly divisible by 3 and evenly divisble by 5
// If counter % 3 == 0 && counter % 5 == 0 print "Fizz Buzz"
// If counter % 3 == 0 print "Fizz"
// If counter % 5 == 0 print "Buzz"
// All other cases, default: print counter

// MARK: - Solution

private func fizzBuzz() {
    for counter in 1...100 {
        switch (counter % 3 == 0, counter % 5 == 0) {
        case (true, false):
            print("Fizz")
        case (false, true):
            print("Buzz")
        case (true, true):
            print("Fizz Buzz")
        default:
            print(counter)
        }
    }
}

// MARK: - Tests


class FizzBuzzTests: XCTestCase {
    
    func testFizzBuzz() {
        fizzBuzz()
    }

}
