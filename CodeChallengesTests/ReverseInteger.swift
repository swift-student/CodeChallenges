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


// MARK: - Solution
private func reverse(_ x: Int) -> Int {
    var digits: [Int] = []
    var input = x
    
    // Get each digit using modulo, and store in digits array
    while input != 0 {
        let digit: Int
        (input, digit) = input.quotientAndRemainder(dividingBy: 10)
        digits.append(digit)
    }
    
    var output = 0
    
    // Reverse the array and construct the ouput
    for (index, digit) in digits.reversed().enumerated() {
        output += digit * Int(pow(10, Double(index)))
    }
    
    // Return 0 when number is outside 32-bit limits
    guard output <= 0x7FFFFFFF && output >= -0x7FFFFFFF else {
        return 0
    }
    
    return output
}

class ReverseInteger: XCTestCase {


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
        XCTAssertEqual(reverse( 2_147_483_648), 0)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
