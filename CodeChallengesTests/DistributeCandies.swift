//
//  DistributeCandies.swift
//  CodeChallengesTests
//
//  Created by Shawn Gee on 8/17/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import XCTest

// MARK: - Challenge

//https://leetcode.com/explore/challenge/card/august-leetcoding-challenge/551/week-3-august-15th-august-21st/3427/
//We distribute some number of candies, to a row of n = num_people people in the following way:
//
//We then give 1 candy to the first person, 2 candies to the second person, and so on until we give n candies to the last person.
//
//Then, we go back to the start of the row, giving n + 1 candies to the first person, n + 2 candies to the second person, and so on until we give 2 * n candies to the last person.
//
//This process repeats (with us giving one more candy each time, and moving to the start of the row after we reach the end) until we run out of candies.  The last person will receive all of our remaining candies (not necessarily one more than the previous gift).
//
//Return an array (of length num_people and sum candies) that represents the final distribution of candies.
//
//
//
//Example 1:
//
//Input: candies = 7, num_people = 4
//Output: [1,2,3,1]
//Explanation:
//On the first turn, ans[0] += 1, and the array is [1,0,0,0].
//On the second turn, ans[1] += 2, and the array is [1,2,0,0].
//On the third turn, ans[2] += 3, and the array is [1,2,3,0].
//On the fourth turn, ans[3] += 1 (because there is only one candy left), and the final array is [1,2,3,1].
//
//Example 2:
//
//Input: candies = 10, num_people = 3
//Output: [5,2,3]
//Explanation:
//On the first turn, ans[0] += 1, and the array is [1,0,0].
//On the second turn, ans[1] += 2, and the array is [1,2,0].
//On the third turn, ans[2] += 3, and the array is [1,2,3].
//On the fourth turn, ans[0] += 4, and the final array is [5,2,3].
 


// MARK: - Plan

// My first plan is to solve it in the same way that it is described
// I will first set up an array, people,  with a length of num_people, setting each element to 0
// I will set up a counter to keep track of how many candies we are giving to each person
// starting with 1 and incrementing each time we give a candy
// I will also make a variable that is equal to the candies input and call it candiesRemaining
// Then I will loop through the array while candies > 0, and on each iteration I will check if the counter
// is smaller than candiesRemaining, and if so, I will subtract the counter
// amount from candiesRemaining and add them to people[i]. I will then add 1 to the counter
// If instead counter is > than candiesRemaining, I will just give all remaining candies to people[i]

// MARK: - Solution

private func distributeCandies(_ candies: Int, _ numPeople: Int) -> [Int] {
    var people = Array(repeating: 0, count: numPeople)
    var candiesRemaining = candies
    var amountToGive = 1
    var currentPerson = 0
    
    while candiesRemaining > amountToGive {
        people[currentPerson] += amountToGive
        
        candiesRemaining -= amountToGive
        amountToGive += 1
        currentPerson = (currentPerson + 1) % numPeople
    }
    
    people[currentPerson] += candiesRemaining
    
    return people
}

// MARK: - Tests

class DistributeCandiesTests: XCTestCase {

    func testDistributing7CandiesAcross4People() {
        XCTAssertEqual(distributeCandies(7, 4), [1,2,3,1])
    }
    
    func testDistributing10CandiesAcross3People() {
        XCTAssertEqual(distributeCandies(10, 3), [5,2,3])
    }

    func testDistributing0CandiesAcross5People() {
        XCTAssertEqual(distributeCandies(0, 5), [0,0,0,0,0])
    }
}
