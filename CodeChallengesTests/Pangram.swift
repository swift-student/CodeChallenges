//
//  Pangram.swift
//  CodeChallengesTests
//
//  Created by Shawn Gee on 8/12/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import XCTest

// MARK: - Challenge

//Find pangrams
//Write a function that returns true if it is given a string that is an English pangram, ignoring
//letter case.
//Tip: A pangram is a string that contains every letter of the alphabet at least once.
//Sample input and output
//• The string "The quick brown fox jumps over the lazy dog." should return true.
//• The string "The quick brown fox jumped over the lazy dog." should return false, because it's missing the S.

// MARK: - Plan

// My plan would be to start with a set of all of the letters from a-z
// I would iterate through the string and remove letters from the set as I encounter them
// until either the set is empty, in which case I would return true, or I reach the end of the string
// in which case I return false as not all of the letters were used

// MARK: - Solution

private func isPangram(_ string: String) -> Bool {
    var allLetters = (97...122).map { Character(UnicodeScalar($0)) }
    
    for character in string.lowercased() {
        allLetters.removeAll(where: { $0 == character })
        
        if allLetters.isEmpty {
            return true
        }
    }
    
    return false
}

// Johnny's solution
private func isPangram2(_ string: String) -> Bool {
    let set = Set(string.lowercased())
    let letters = set.filter { $0 >= "a" && $0 <= "z" }
    return letters.count == 26
}

// MARK: - Tests

class PangramTests: XCTestCase {

    func testHelloIsNotPangram() {
        // given
        let input = "Hello"
        
        // when
        let result = isPangram(input)
        
        // then
        XCTAssertFalse(result)
    }
    
    func testQuickBrownFoxIsPangram() {
        // given
        let input = "The quick brown fox jumps over the lazy dog."
        
        // when
        let result = isPangram(input)
        
        // then
        XCTAssertTrue(result)
    }
    
    func testQuickBrownFoxJumpedIsNotPangram() {
        // given
        let input = "The quick brown fox jumped over the lazy dog."
        
        // when
        let result = isPangram(input)
        
        // then
        XCTAssertFalse(result)
    }
    
    func testEmptyStringIsNotPangram() {
        // given
        let input = ""
        
        // when
        let result = isPangram(input)
        
        // then
        XCTAssertFalse(result)
    }
    
    func testUppercaseAlphabetIsPangram() {
        // given
        let input = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        
        // when
        let result = isPangram(input)
        
        // then
        XCTAssertTrue(result)
    }
}
