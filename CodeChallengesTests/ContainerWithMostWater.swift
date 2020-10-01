//
//  ContainerWithMostWater.swift
//  CodeChallengesTests
//
//  Created by Shawn Gee on 10/1/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import XCTest

// MARK: - Challenge

//https://leetcode.com/problems/container-with-most-water/
//Given n non-negative integers a1, a2, ..., an , where each represents a point at coordinate (i, ai). n vertical lines are drawn such that the two endpoints of line i is at (i, ai) and (i, 0). Find two lines, which together with x-axis forms a container, such that the container contains the most water.
//Note: You may not slant the container and n is at least 2.
//Example:
//
//Input: [1,8,6,2,5,4,8,3,7]
//Output: 49

// MARK: - Plan

// The tallest sides will not neccessarily produce the container with the largest volume
// A simple solution might be to just iterate through all the possible combinations of start
// and end indices, and calculate the area for each pair. Keep track of the largest area found
// and increment as larger areas are discovered.
// This solution is O(n²)

// Let's start from the outside and only move the pointer at the smallest wall in
// This should allow us to reduce our runtime complexity to O(n)

// MARK: - Solution

private func maxArea(_ height: [Int]) -> Int {
    var maxArea = 0
    
    var left = 0
    var right = height.count - 1
    
    while left < right {
        let width = right - left
        let minHeight: Int
        
        if height[left] < height[right] {
            minHeight = height[left]
            left += 1
        } else {
            minHeight = height[right]
            right -= 1
        }
        
        maxArea = max(width * minHeight, maxArea)
    }

    return maxArea
}

// MARK: - Tests

class ContainerWithMostWaterTests: XCTestCase {

    func testExampleArrayMaxAreaIs49() {
        XCTAssertEqual(maxArea([1,8,6,2,5,4,8,3,7]), 49)
    }
    
    func testTallWallsInMiddleCreateAreaOf200() {
        XCTAssertEqual(maxArea([9,9,9,9,9,9,100,9,100,9,9,9,9,9,9,9]), 200)
    }
    
    func testSmallWallsOnOutsideCreateAreaOf135() {
        XCTAssertEqual(maxArea([9,9,9,9,9,9,9,100,100,9,9,9,9,9,9,10]), 135)
    }

}
