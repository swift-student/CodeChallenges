//
//  ExcelCollumns.swift
//  CodeChallengesTests
//
//  Created by Shawn Gee on 8/10/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import XCTest

// MARK: - Challenge

//Given a column title as appear in an Excel sheet, return its corresponding column number.
//
//For example:
//
//    A -> 1
//    B -> 2
//    C -> 3
//    ...
//    Z -> 26
//    AA -> 27
//    AB -> 28
//    ...
//Example 1:
//
//Input: "A"
//Output: 1
//Example 2:
//
//Input: "AB"
//Output: 28
//Example 3:
//
//Input: "ZY"
//Output: 701
//
//
//Constraints:
//
//1 <= s.length <= 7
//s consists only of uppercase English letters.
//s is between "A" and "FXSHRXW".

// MARK: - Plan

// In short, we are converting from a base 26 number, to a standard base 10 number
// So starting with the rightmost digit being the ones place, the next digit to the left
// is the 26th place and then the next digit to the left of that is the 676th place
// One odd thing is there is no "0" digit, with A being the lowest as 1
// So the value of each place is calculated as 26 ^ p, just as it would be in base 10 or 2 or 8

// My plan is to loop through the characters from right to left, multiply them by 26 to the power
// of the place we are working on, and add that to a sum, returning that sum at the end
// I do need to map the value of the character to a number from 1 to 26
// I can do this by subtracting 64 as A has an ascii value of 65

// MARK: - Solution

/// Calculates the corresponding number for a column with a given title in Excel
/// - Parameter s: The input string, treated as though it is a base 26 number where A = 1 and Z = 26
/// - Returns: A base 10 number that would correspond to the column number in Excel
private func titleToNumber(_ s: String) -> Int {
    var number = 0
    var factor = 1
    
    for character in s.reversed() {
        guard let asciiValue = character.asciiValue,
            asciiValue > 64 && asciiValue < 91 else { continue } // ignores non-uppercase characters
        let digit = asciiValue - 64
        
        number += Int(digit) * factor
        factor *= 26
    }
    
    return number
}

// MARK: - Tests

class ExcelColumnsTests: XCTestCase {
    
    func test_emptyString_titleToNumber_is0() {
        // given
        let title = ""
        
        // when
        let number = titleToNumber(title)
        
        // then
        XCTAssertEqual(number, 0)
    }

    func test_A_titleToNumber_is1() {
        // given
        let title = "A"
        
        // when
        let number = titleToNumber(title)
        
        // then
        XCTAssertEqual(number, 1)
    }
    
    func test_ZY_titleToNumber_is701() {
        // given
        let title = "ZY"
        
        // when
        let number = titleToNumber(title)
        
        // then
        XCTAssertEqual(number, 701)
    }
    
    func test_AA123AA_titleToNumber_is18279() {
        // given
        let title = "AA123AA"
        
        // when
        let number = titleToNumber(title)
        
        // then
        XCTAssertEqual(number, 18279)
    }
}
