//
//  PowerOfFour.swift
//  CodeChallengesTests
//
//  Created by Shawn Gee on 8/4/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import XCTest

// MARK: - Challenge

//https://leetcode.com/explore/challenge/card/august-leetcoding-challenge/549/week-1-august-1st-august-7th/3412/

//Given an integer (signed 32 bits), write a function to check whether it is a power of 4.
//
//Example 1:
//
//Input: 16
//Output: true
//Example 2:
//
//Input: 5
//Output: false
//Follow up: Could you solve it without loops/recursion?

// MARK: - Plan

// 4 =  0x100
// 16 = 0x10000
// 64 = 0x1000000

// Only one bit, the msb, can be 1
// The number of trailing zeroes must be evenly divisible by 2

// MARK: - Solution

func isPowerOfFour(_ num: Int) -> Bool {
    return num.nonzeroBitCount == 1 && num.trailingZeroBitCount % 2 == 0
}

// MARK: - Tests

class PowerOfFourTests: XCTestCase {
    func test_4_isPowerOfFour() {
        XCTAssertTrue(isPowerOfFour(4))
    }
    
    func test_16_isPowerOfFour() {
        XCTAssertTrue(isPowerOfFour(16))
    }
    
    func test_32_isNotPowerOfFour() {
        XCTAssertFalse(isPowerOfFour(32))
    }
    
    func test_2_isNotPowerOfFour() {
        XCTAssertFalse(isPowerOfFour(2))
    }
    
    func test_1_isPowerOfFour() {
        // 4 ^ 0 = 1
        XCTAssertTrue(isPowerOfFour(1))
    }
}
