//
//  MissingNumbersInArray.swift
//  CodeChallengesTests
//
//  Created by Shawn Gee on 10/2/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import XCTest

// MARK: - Challenge
// Paul Hudson's Swift Coding Challenges

//Challenge 40: Missing numbers in array
//Difficulty: Easy
//Create a function that accepts an array of unsorted numbers from 1 to 100 where zero or more
//numbers might be missing, and returns an array of the missing numbers.
//Sample input and output
//If your test array were created like this:
//var testArray = Array(1...100)
//testArray.remove(at: 25)
//testArray.remove(at: 20)
//testArray.remove(at: 6)
//Then your method should [7, 21, 26], because those are the numbers missing from the array.


// MARK: - Plan
// I will make my function a little more generic by passing in the range I want to check
// Using a set will speed up the operation of diffing with a complete set
// So I will take the input array, convert it to a set, make a set from the range passed in,
// and return the difference between the two as an array.
// Update: Changed solution to automatically order the missing numbers by making the range into an
// array instead of set, and iterating through that range finding the missing numbers in the input.

// MARK: - Solution

private func missingNumbersInArray(_ array: [Int], withRange range: ClosedRange<Int>) -> [Int] {
    let inputNumbers = Set(array)
    let expectedNumbers = Array(range)
    var missingNumbers: [Int] = []
    
    for number in expectedNumbers {
        if !inputNumbers.contains(number) {
            missingNumbers.append(number)
        }
    }
    
    return missingNumbers
}

// MARK: - Tests

class MissingNumbersInArrayTests: XCTestCase {
    func testArrayAfterRemoving3NumbersIsMissingThose3Numbers() {
        var testArray = Array(1...100)
        testArray.remove(at: 25)
        testArray.remove(at: 20)
        testArray.remove(at: 6)
        
        let missingNumbers = missingNumbersInArray(testArray, withRange: 1...100)
        XCTAssertEqual(missingNumbers, [7, 21, 26])
    }
    
    func testArrayWithOnly3NumbersIsMising97Numbers() {
        let testArray = [7, 49, 99]
        
        let missingNumbers = missingNumbersInArray(testArray, withRange: 1...100)
        XCTAssertEqual(missingNumbers.count, 97)
    }
}
