//
//  IsomorphicValues.swift
//  CodeChallengesTests
//
//  Created by Shawn Gee on 10/7/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import XCTest

// MARK: - Challenge

//Challenge 57: Isomorphic values
//Difficulty: Easy
//Write a function that accepts two values and returns true if they are isomorphic. That is, each
//part of the value must map to precisely one other, but that might be itself.
//Tip: Strings A and B are considered isomorphic if you can replace all instances of each letter with another. For example, “tort” and “pump” are isomorphic, because you can replace both Ts with a P, the O with a U, and the R with an M. For integers you compare individual digits, so 1231 and 4564 are isomorphic numbers. For arrays you compare elements, so [1, 2, 1] and [4, 8, 4] are isomorphic.

//Sample input and output
//These are all isomorphic values:
//• “clap” and “slap”
//• “rum” and “mud”
//• “pip” and “did”
//• “carry” and “baddy”
//• “cream” and “lapse”
//• 123123 and 456456
//• 3.14159 and 2.03048
//• [1, 2, 1, 2, 3] and [4, 5, 4, 5, 6]
//These are not isomorphic values:
//• “carry” and “daddy” – the Rs have become D, but C has also become D.
//• “did” and “cad” – the first D has become C, but the second has remained D.
//• “maim” and “same” – the first M has become S, but the second has become E.
//• “curry” and “flurry” – the strings have different lengths.
//• 112233 and 112211 – the number 1 is being mapped to 1, and the number 3 is also
//being mapped to 1.


// MARK: - Plan

// So for two vaues to be isomorphic they need to repeat in the same place.
// The vaues will need to be collections for us to check the elements.
// We can use a dictionary to store the indices where a certain element has been located.
// While iterating through all of the elements, if at any time the indices where the two
// corresponding elements have been located do not match up, the values are not isometric.

// MARK: - Solution

// Original solution
//private func isomorphic2<T: Collection>(valueA: T, valueB: T) -> Bool where T.Element: Hashable {
//    guard valueA.count == valueB.count, valueA.count > 0 else { return false }
//
//    var indicesForElementA: [T.Element: [Int]] = [:]
//    var indicesForElementB: [T.Element: [Int]] = [:]
//
//    var iteratorA = valueA.makeIterator()
//    var iteratorB = valueB.makeIterator()
//
//    var index = 0
//    var elementA = iteratorA.next()
//    var elementB = iteratorB.next()
//
//    while elementA != nil && elementB != nil {
//        indicesForElementA[elementA!, default: []].append(index)
//        indicesForElementB[elementB!, default: []].append(index)
//
//        guard indicesForElementA[elementA!] == indicesForElementB[elementB!] else {
//            return false
//        }
//
//        index += 1
//        elementA = iteratorA.next()
//        elementB = iteratorB.next()
//    }
//
//    return true
//}

// New solution after looking at Paul's and realizing my performance wasn't ideal
// Also realized that I was testing with all strings and not Ints and Doubles, which aren't Collections
// Switched to using a mapping rather than dictionaries of indices
// Also use zip for clarity and brevity
private func isomorphic(valueA: Any, valueB: Any) -> Bool {
    let arrayA = Array(String(describing: valueA))
    let arrayB = Array(String(describing: valueB))
    
    guard arrayA.count == arrayA.count else { return false } // not isomorphic if different lengths
    var mapping: [Character: Character] = [:] // create mapping of elements from one character to the other

    for (characterA, characterB) in zip(arrayA, arrayB) { // use zip to iterate through both arrays
        if mapping[characterA] == nil { // if no mapping for a
            if mapping.values.contains(characterB) { // if b is mapped to another a
                return false // then it's not isomorphic
            }
            mapping[characterA] = characterB
        } else if mapping[characterA] != characterB { // if the mapping for a is not b
            return false // then it's not isomorphic
        }
    }
    
    return true
}

// Paul's solution
private func challenge57(first firstValue: Any, second secondValue: Any) -> Bool {
    let first = String(describing: firstValue)
    let second = String(describing: secondValue)
    
    guard first.count == second.count else { return false }
    
    var characterMap = [Character: Character]()
    let firstArray = Array(first)
    let secondArray = Array(second)

    for (index, character) in firstArray.enumerated() {
        let otherCharacter = secondArray[index]
        if let currentMapping = characterMap[character] {
            if currentMapping != otherCharacter {
                return false
            }
        } else {
            if characterMap.values.contains(otherCharacter) {
                return false
            }
            characterMap[character] = otherCharacter
            
        }
    }
    
    return true
}


// MARK: - Tests

class IsomorphicValuesTests: XCTestCase {
    
    // Are isomorphic tests
    
    func test_ClapAndSlap_AreIsomorphic() {
        XCTAssertTrue(isomorphic(valueA: "clap", valueB: "slap"))
    }
    
    func test_PipAndDid_AreIsomorphic() {
        XCTAssertTrue(isomorphic(valueA: "pip", valueB: "did"))
    }
    
    func test_CarryAndBaddy_AreIsomorphic() {
        XCTAssertTrue(isomorphic(valueA: "carry", valueB: "baddy"))
    }
    
    func test_CreamAndLapse_AreIsomorphic() {
        XCTAssertTrue(isomorphic(valueA: "cream", valueB: "lapse"))
    }
    
    func test_123123And456456_AreIsomorphic() {
        XCTAssertTrue(isomorphic(valueA: [1, 2, 1, 2, 3], valueB: [4, 5, 4, 5, 6]))
    }
    
    func test_3point14159and2point03048_AreIsomorphic() {
        XCTAssertTrue(isomorphic(valueA: 3.14159, valueB: 2.03048))
    }

    // Not isomorphic tests
    
    func test_CarryAndDaddy_AreNotIsomorphic() {
        XCTAssertFalse(isomorphic(valueA: "carry", valueB: "daddy"))
    }
    
    func test_DidAndCad_AreNotIsomorphic() {
        XCTAssertFalse(isomorphic(valueA: "did", valueB: "cad"))
    }
    
    func test_MaimAndSame_AreNotIsomorphic() {
        XCTAssertFalse(isomorphic(valueA: "maim", valueB: "same"))
    }
    
    func test_CurryAndFlurry_AreNotIsomorphic() {
        XCTAssertFalse(isomorphic(valueA: "curry", valueB: "flurry"))
    }

    func test_112233And112211_AreNotIsomorphic() {
        XCTAssertFalse(isomorphic(valueA: 112233, valueB: 112211))
    }
    
    // Performance tests
    
    func test_PerformanceOfMySolution() {
        let testString = String(repeating: "0123456789", count: 1000)
        
        measure {
            _ = isomorphic(valueA: testString, valueB: testString)
        }
    }

    func test_PerformanceOfPaulsSolution() {
        let testString = String(repeating: "0123456789", count: 1000)
        
        measure {
            _ = challenge57(first: testString, second: testString)
        }
    }
}
