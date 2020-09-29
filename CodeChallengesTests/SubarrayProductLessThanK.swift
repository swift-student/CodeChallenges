//
//  SubarrayProductLessThanK.swift
//  CodeChallengesTests
//
//  Created by Shawn Gee on 9/28/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import XCTest

// MARK: - Challenge

//https://leetcode.com/explore/challenge/card/september-leetcoding-challenge/557/week-4-september-22nd-september-28th/3475/
//You are given an array of positive integers nums.
//
//Count and print the number of (contiguous) subarrays where the product of all the elements in the subarray is less than k.
//
//Example 1:
//
//Input: nums = [10, 5, 2, 6], k = 100
//Output: 8
//Explanation: The 8 subarrays that have product less than 100 are: [10], [5], [2], [6], [10, 5], [5, 2], [2, 6], [5, 2, 6].
//Note that [10, 5, 2] is not included as the product of 100 is not strictly less than k.
//Note:
//
//0 < nums.length <= 50000.
//0 < nums[i] < 1000.
//0 <= k < 10^6.

// MARK: - Plan

// Sliding Window:
// Move a window through the array, adding the number of subarrays that have a product
// less than k to a running tally, count. Keep track of product of window while moving along,
// multiply while incrementing right index, divide while incrementing left index.
// Do this with a while loop that runs while left index is less than `nums.count`:
//   If the product is more than k, increment the left index, continue
//   If the right index is equal to the left index, increment it, continue
//   Try to move the right index as far as possible to the right, before adding to the count
//   The number of subarrays that should be added is then equal to rightIndex - leftIndex
//   Increment the left index

// MARK: - Solution

/// Counts the number of subarrays in the input array `nums` where the product of all the elements
/// in the subarray is less than `k`.
/// - Parameters:
///   - nums: The array of numbers to evaluate.
///   - k: The max product of the subarrays (non-inclusive)
/// - Returns: A count of subarray products less than `k`.
private func numSubarrayProductLessThanK(_ nums: [Int], _ k: Int) -> Int {
    guard !nums.isEmpty else { return 0 }
    
    var leftIndex = 0
    var rightIndex = 1
    var product = nums[leftIndex] // product of window (leftIndex..<rightIndex)
    var count = 0 // num of subarray products less than k
    
    /// Increments the left index by first dividing the product by the left index
    func incrementLeft() {
        product /= nums[leftIndex]
        leftIndex += 1
    }
    
    /// Increments the right index by first multiplying the product by the right index
    func incrementRight() {
        product *= nums[rightIndex]
        rightIndex += 1
    }
    
    while leftIndex < nums.count {
        guard product < k else {
            incrementLeft()
            continue
        }
        
        guard rightIndex > leftIndex else {
            incrementRight()
            continue
        }
        
        // As move the right index as far as possible while maintaining product < k
        while rightIndex < nums.count && product * nums[rightIndex] < k {
            incrementRight()
        }
        
        count += rightIndex - leftIndex
        incrementLeft()
    }
    
    return count
}

class SubarrayProductLessThanK: XCTestCase {


    func testExample() {
        let nums = [10, 5, 2, 6]
        let k = 100
        XCTAssertEqual(numSubarrayProductLessThanK(nums, k), 8)
    }
    
    func testExample2() {
        let nums = [1, 1, 1, 1, 11, 1, 1, 1, 1, 1]
        let k = 10
        XCTAssertEqual(numSubarrayProductLessThanK(nums, k), 25)
    }

}
