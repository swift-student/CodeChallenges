//
//  FindDuplicatesInArray.swift
//  CodeChallengesTests
//
//  Created by Shawn Gee on 8/6/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import XCTest

// MARK: - Challenge
    
//https://leetcode.com/explore/challenge/card/august-leetcoding-challenge/549/week-1-august-1st-august-7th/3414/

//    Given an array of integers, 1 ≤ a[i] ≤ n (n = size of array), some elements appear twice and others appear once.
//
//    Find all the elements that appear twice in this array.
//
//    Could you do it without extra space and in O(n) runtime?
//
//    Example:
//
//    Input:
//    [4,3,2,7,8,2,3,1]
//
//    Output:
//    [2,3]

// MARK: - Plan 1

// The simple way to do this in O(n) time would involve using a set to determine which characters have already appeared
// However this would require O(n) extra space
// Let's first solve it in this way

// MARK: - Solution 1

private func findDuplicates(_ nums: [Int]) -> [Int] {
    var numSet: Set<Int> = []
    var result: [Int] = []

    for num in nums {
        if numSet.contains(num) {
            result.append(num)
        } else {
            numSet.insert(num)
        }
    }

    return result
}

// MARK: - Plan 2

// The input array has a special requirement though in that each integer is going to be in the range of 1...n
// We will first create a mutable copy of the input array

// When we encounter num the first time (for num in numbers), we will use abs(num - 1) as an index and set the number
// at that index to it's negative.
// The next time we encounter it, we will check to see if the value at that index minus one is less than one,
// and if so append the absolute value of that number to our result

// MARK: - Solution 2

/// This function determines which numbers appear twice in an array containing only integers from 1...n.
/// It does so by using the each integer as if it is a key to a hash map, and setting the value at
/// the corresponding index (num + 1) in the input array to it's inverse. This way numbers which have
/// appeared prior can be determined by the fact that the number at num + 1 in the array is less than 0.
/// - Parameter nums: An array of integers where `1 <= nums[i] <= nums.count`
/// - Returns: An array of integers that appeared twice in the input array
private func findDuplicates2(_ nums: [Int]) -> [Int] {
    var numbers = nums
    var result: [Int] = []
    
    for num in numbers {
        if numbers[abs(num) - 1] < 0 { // Checks if this number has been encountered before
            result.append(abs(num))
        } else {
            numbers[abs(num) - 1] = -numbers[abs(num) - 1] // Inverts number at corresponding index
        }
    }
    
    return result
}

// MARK: - Tests

class FindDuplicatesInArrayTests: XCTestCase {
    func testFindDuplicates() {
        XCTAssertEqual(Set(findDuplicates2([4,3,2,7,8,2,3,1])), Set([2, 3]))
    }
    
    func testFindDuplicatesWithEmptyArray() {
        XCTAssertEqual(findDuplicates2([]), [])
    }
}

