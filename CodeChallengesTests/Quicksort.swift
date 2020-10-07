//
//  Quicksort.swift
//  CodeChallengesTests
//
//  Created by Shawn Gee on 10/6/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import XCTest

// MARK: - Challenge
// Paul Hudson's Swift Coding Challenges

//Challenge 59: Quicksort
//Difficulty: Tricky
//Create an extension for arrays that sorts them using the quicksort algorithm.
//Tip #1: The quicksort algorithm picks an item from its array to use as the pivot point, then splits itself into either two parts (less than or greater than) or three (less, greater, or equal). These parts then repeat the pivot and split until the entire array has been split, then it gets rejoined so that less, equal, and greater are in order.
//Tip #2: I can write quicksort from memory, but I cannot write fully optimized quicksort from memory. It’s a complex beast to wrangle, and it requires careful thinking – honestly, I have better things to keep stored in what little space I have up there! So, don’t feel bad if your attempt is far from ideal: there’s no point creating a perfect solution if you struggle to remember it during an interview.
//Tip #3: Quicksort is an algorithm so well known and widely used that you don’t even write a space in its name – it’s “quicksort” rather than “quick sort”.

// MARK: - Plan

// I will make an extension on Array where Element: Comparable
// I need to use recursion to split up the input array into smaller pieces until it is broken down completely
// The first task is to pick a pivot point. I will use the last element to keep things simple.
// Then I need to have arrays for elements that are lower and higher
// For all of the elements in the array, I will sort them into one of these two buckets
// At the end I will return lower.quicksorted() + pivot + higher.quicksorted()

// Update: changed to use three buckets and random element

// MARK: - Solution

extension Array where Element: Comparable {
    func quicksorted() -> Array<Element> {
        // Base case
        guard count > 1 else { return self }
        
        guard let pivot = self.randomElement() else { return self }
        var lower: Array<Element> = []
        var higher: Array<Element> = []
        var equal: Array<Element> = []
        
        for element in self {
            if element < pivot {
                lower.append(element)
            } else if element > pivot {
                higher.append(element)
            } else {
                equal.append(element)
            }
        }
        
        return lower.quicksorted() + equal + higher.quicksorted()
    }
    
    func quicksorted2() -> Array<Element> {
        func quicksort(array: inout Array<Element>, left: Int, right: Int) {
            // Base case
            guard left < right else { return }
            
            let pivot = array[right]
            var splitPoint = left
            
            for i in left..<right {
                if array[i] < pivot {
                    (array[i], array[splitPoint]) = (array[splitPoint], array[i])
                    splitPoint += 1
                }
            }
            
            (array[right], array[splitPoint]) = (array[splitPoint], array[right])
            
            quicksort(array: &array, left: left, right: splitPoint - 1)
            quicksort(array: &array, left: splitPoint + 1, right: right)
        }
        
        var mutableSelf = self
        quicksort(array: &mutableSelf, left: 0, right: mutableSelf.count - 1)
        
        return mutableSelf
    }
}

// MARK: - Tests

class QuicksortTests: XCTestCase {

    func testQuicksortingArrayOfIntegers_ResultsInSortedArray() {
        XCTAssertEqual([12, 5, 4, 9, 3, 2, 1].quicksorted(), [1, 2, 3, 4, 5, 9, 12])
    }
    
    func testQuicksortingArrayOfLetters_ResultsInSortedArray() {
        XCTAssertEqual(["f", "a", "b"].quicksorted(), ["a", "b", "f"])
    }
    
    func testQuicksortingEmptyArray_ResultsInEmptyArray() {
        XCTAssertEqual([String]().quicksorted(), [])
    }
    
    func testQuicksorting2ArrayOfIntegers_ResultsInSortedArray() {
        XCTAssertEqual([12, 5, 4, 9, 3, 2, 1].quicksorted2(), [1, 2, 3, 4, 5, 9, 12])
    }
    
    func testQuicksorting2ArrayOfLetters_ResultsInSortedArray() {
        XCTAssertEqual(["f", "a", "b"].quicksorted2(), ["a", "b", "f"])
    }
    
    func testQuicksorting2EmptyArray_ResultsInEmptyArray() {
        XCTAssertEqual([String]().quicksorted2(), [])
    }

    func testPerformance() throws {
        var numbers: [Int] = []
        
        for _ in 1...10_000 {
            numbers.append(Int.random(in: 1...10_000))
        }
        
        self.measure {
            _ = numbers.quicksorted()
        }
    }
    
    func testPerformance2() throws {
        var numbers: [Int] = []
        
        for _ in 1...10_000 {
            numbers.append(Int.random(in: 1...10_000))
        }
        
        self.measure {
            _ = numbers.quicksorted2()
        }
    }

}
