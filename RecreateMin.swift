//
//  RecreateMin.swift
//  CodeChallengesTests
//
//  Created by Shawn Gee on 10/5/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import XCTest

// MARK: - Challenge
// Paul Hudson's Swift Coding Challenges

//Challenge 47: Recreate min()
//Difficulty: Tricky
//Write an extension for all collections that reimplements the min() method.
//Sample input and output
//• The code [1, 2, 3].challenge47() should return 1.
//• The code ["q", "f", "k"].challenge47() should return “f”.
//• The code [4096, 256, 16].challenge47() should return 16.
//• The code [String]().challenge47() should return nil.

// MARK: - Plan

// To implement a function that returns the minimum value element of a collection, the elements would have
// to conform to comparable
// So I will make an extension to collection where Element: Comparable
// In a function, I need to create a variable that will hold the minimum element,
// setting it to nil to start
// I will then loop through all of the elements in the collection comparing them to the minimum element
// I can use min() to set the minimum element to the lesser of the two elements being compared
// Finally, I will simply return the minimum element

// Update: To make things easier, I set minElement initially to the first element and then iterated
// throught the rest of the elements using .dropFirst()


// MARK: - Solution

private extension Collection where Element: Comparable {
    func challenge47() -> Element? {
        guard var minElement: Element = self.first else {
            return nil
        }
        
        for element in self.dropFirst() {
            minElement = Swift.min(minElement, element)
        }
        
        return minElement
    }

    // Paul's solution
    func challenge47c() -> Iterator.Element? {
        var it = makeIterator()
        guard var lowest = it.next() else { return nil }
        while let item = it.next() {
            if item < lowest {
                lowest = item
            }
        }
        return lowest
    }
}



// MARK: - Tests

class RecreateMinTests: XCTestCase {

    func testMinOfArrayOfIntsIs1() {
        XCTAssertEqual([1, 2, 3].challenge47(), 1)
    }
    
    func testMinOfAnotherArrayOfIntsIs16() {
        XCTAssertEqual([4096, 256, 16].challenge47(), 16)
    }
    
    func testMinOfArrayOfLettersIsF() {
        XCTAssertEqual(["q", "f", "k"].challenge47(), "f")
    }
    
    func testMinOfEmptyStringArrayIsNil() {
        XCTAssertNil([String]().challenge47())
    }
    
    func testMinOfArrayOfDoublesIs8point9() {
        XCTAssertEqual([124.2, 498.4, 89.8, 8.9, 298.1].challenge47(), 8.9)
    }
    
    func testPerformance() {
        let testArray = Array(1...1_000_000)
        measure {
            _ = testArray.challenge47()
        }
    }
    
    func testPerformancePaul() {
        let testArray = Array(1...1_000_000)
        measure {
            _ = testArray.challenge47c()
        }
    }
}
