//
//  NumberNotDuplicated.swift
//  CodeChallengesTests
//
//  Created by Shawn Gee on 10/8/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import XCTest

// MARK: - Challenge

// Write a function that given an array of integers with every number
// having a duplicate except for one, find and return that number.

// MARK: - Plan

// I need to iterate through all numbers once to be sure which number has no duplicate
// I will put the numbers in a first set as I run into them the first time
// Then when I encounter numbers that are already in the first set, I will put them in a set of duplicates
// at the end I will return the difference between the first set and the duplicates

// MARK: - Solution

private func numberNotDuplicated(in numbers: [Int]) -> Int? {
    var numberSet = Set<Int>()
    var duplicates = Set<Int>()
    
    for number in numbers {
        if numberSet.contains(number) {
            duplicates.insert(number)
        } else {
            numberSet.insert(number)
        }
    }
    
    return duplicates.symmetricDifference(numberSet).first
}


private func numberNotDuplicated2(in numbers: [Int]) -> Int? {
    var numberSet = Set<Int>()
    
    for number in numbers {
        if numberSet.contains(number) {
            numberSet.remove(number)
        } else {
            numberSet.insert(number)
        }
    }
    
    return numberSet.first
}

// MARK: - Tests

class NumberNotDuplicatedTests: XCTestCase {

    func test_NumberNotDuplicatedInArray_Is3() {
        XCTAssertEqual(numberNotDuplicated(in: [1, 1, 2, 2, 3, 4, 4]), 3)
    }
    
    func test_NumberNotDuplicatedInArray_IsNil() {
        XCTAssertEqual(numberNotDuplicated(in: [1, 1, 2, 2, 3, 3, 4, 4]), nil)
    }
    
    func test_NumberNotDuplicatedInEmptyArray_IsNil() {
        XCTAssertEqual(numberNotDuplicated(in: []), nil)
    }
    
    func test_PerformanceUsingTwoSets() {
        let numbers = Array(1...10_000) + Array(1...10_001)
        self.measure {
            _ = numberNotDuplicated(in: numbers)
        }
    }
    
    func test_PerformanceUsingOneSet() {
        let numbers = Array(1...10_000) + Array(1...10_001)
        self.measure {
            _ = numberNotDuplicated2(in: numbers)
        }
    }
}
