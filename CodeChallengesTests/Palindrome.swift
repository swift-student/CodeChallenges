//
//  PalindromeTests.swift
//  CodeChallenges
//
//  Created by Shawn Gee on 8/4/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import XCTest

// MARK: - Challenge

//https://leetcode.com/explore/challenge/card/august-leetcoding-challenge/549/week-1-august-1st-august-7th/3411/

//Given a string, determine if it is a palindrome, considering only alphanumeric characters and ignoring cases.
//
//Note: For the purpose of this problem, we define empty string as valid palindrome.
//
//Example 1:
//
//Input: "A man, a plan, a canal: Panama"
//Output: true
//Example 2:
//
//Input: "race a car"
//Output: false

// MARK: - Plan

// A palindrome means that reversing a string results in the same string
// We need to be sure to ignore case and punctuation while determining if a string
// is a palindrome.
// Rather than stripping the punctuation, I could simply skip over any punctuation
// while looping through each character from the front and from the back
// I can then do a case-insensitive compare on each character with these two pointers
// If the characters aren't equal, it's not a palindrome
// If I get to the center, then it is a palindrome and I can return

// MARK: - Solution
 
func isPalindrome(_ s: String) -> Bool {
    guard !s.isEmpty else { return true }

    var front = s.startIndex
    var back = s.index(before: s.endIndex)

    while front < back {
        // Ignore characters that aren't letters or numbers
        guard s[front].isLetter || s[front].isNumber else {
            front = s.index(after: front)
            continue
        }
        guard s[back].isLetter || s[back].isNumber else {
            back = s.index(before: back)
            continue
        }
        
        // If characters aren't the same reading from front and back, it's not a palindrome
        if s[front].lowercased() != s[back].lowercased() {
            return false
        }

        front = s.index(after: front)
        back = s.index(before: back)
    }

    return true
}

// A more succinct, but less performant version
func isPalindrome2(_ s: String) -> Bool {
    let stringArray = Array(s.filter { $0.isLetter || $0.isNumber }.lowercased())
    return stringArray == stringArray.reversed()
}

// MARK: - Tests

class PalindromeTests: XCTestCase {

    func test_hello_isNotPalindrome() {
        // given
        let string = "hello"
       
        // then
        XCTAssertFalse(isPalindrome(string))
    }
    
    func test_racecar_isPalindrome() {
        // given
        let string = "racecar"
        
        // then
        XCTAssertTrue(isPalindrome(string))
    }
    
    func test_Race_Car_isPalindrome() {
        // given
        let string = "Race Car"
        
        // then
        XCTAssertTrue(isPalindrome(string))
    }
    
    func test_112211_isPalindrome() {
        // given
        let string = "112211"
        
        // then
        XCTAssertTrue(isPalindrome(string))
    }
    
    func test_a_isPalindrome() {
        // given
        let string = "a"
        
        // then
        XCTAssertTrue(isPalindrome(string))
    }
    
    func test_palindromeWithPunctuation_isPalindrome() {
        // given
        let string = "!*R(a.,c;e\' #C%a^r+"
        
        // then
        XCTAssertTrue(isPalindrome(string))
    }
    
    func test_emptyString_isPalindrome() {
        // given
        let string = ""
        
        // then
        XCTAssertTrue(isPalindrome(string))
    }

    func testPerformanceExample() throws {
        self.measure {
            _ = isPalindrome("225522")
        }
    }
}
