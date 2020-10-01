//
//  ReverseInteger.swift
//  CodeChallengesTests
//
//  Created by Shawn Gee on 9/30/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import XCTest

// MARK: - Challenge

//https://leetcode.com/problems/reverse-integer/
//Given a 32-bit signed integer, reverse digits of an integer.
//
//Example 1:
//
//Input: 123
//Output: 321
//Example 2:
//
//Input: -123
//Output: -321
//Example 3:
//
//Input: 120
//Output: 21
//Note:
//Assume we are dealing with an environment which could only store integers within the 32-bit signed integer range: [−231,  231 − 1]. For the purpose of this problem, assume that your function returns 0 when the reversed integer overflows.

// MARK: - Plan
// The most obvious way to solve this would involve converting the integer into a string,
// then reversing the string, and finally converting the string back into an integer.

// I could also get the digits one at a time by using modulo, putting them into an array,
// then iterating backwards through the array, use the digits to construct the reversed integer.

// Update: no need to use an array, simply add the digits to the ouput by saying
// output = output * 10 + digit

// MARK: - Solution
private func reverse(_ x: Int) -> Int {
    var input = x
    var output = 0
    
    // Get each digit using modulo and append to output
    while input != 0 {
        let digit: Int
        (input, digit) = input.quotientAndRemainder(dividingBy: 10)
        output = output * 10 + digit
    }
    
    // Return 0 when number is outside 32-bit limits
    guard output >= Int32.min && output <= Int32.max else {
        return 0
    }
    
    return output
}

class ReverseIntegerTests: XCTestCase {

    func test123ReversedIs321() throws {
        XCTAssertEqual(reverse(123), 321)
    }
    
    func testNegative123ReversedIsNegative321() {
        XCTAssertEqual(reverse(-123), -321)
    }
    
    func test120ReversedIs21() {
        XCTAssertEqual(reverse(120), 21)
    }
    
    func test584019ReversedIs910485() {
        XCTAssertEqual(reverse(584019), 910485)
    }
    
    func testReverseOverflowReturns0() {
        XCTAssertEqual(reverse( 2_147_483_008), 0)
    }
}
