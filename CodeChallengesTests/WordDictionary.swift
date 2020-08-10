//
//  WordDictionary.swift
//  CodeChallengesTests
//
//  Created by Shawn Gee on 8/5/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import XCTest

// MARK: - Challenge

//https://leetcode.com/explore/challenge/card/august-leetcoding-challenge/549/week-1-august-1st-august-7th/3413/

//Design a data structure that supports the following two operations:
//
//void addWord(word)
//bool search(word)
//search(word) can search a literal word or a regular expression string containing only letters a-z or .. A . means it can represent any one letter.
//
//Example:
//
//addWord("bad")
//addWord("dad")
//addWord("mad")
//search("pad") -> false
//search("bad") -> true
//search(".ad") -> true
//search("b..") -> true
//Note:
//You may assume that all words are consist of lowercase letters a-z.

// MARK: - Plan

// I need to impliment a prefix tree, or trie
// Each node will have a dictionary of character to node, mapping the possible next characters
// Each nodes will also have a terminator property

// When inserting, if the index is equal to the end index of the string,
// I will simply set the terminator property to true
// Otherwise I will check the dictionary for the character provided
// and make a node if not present, then tell the node to link the character at the index
// after the current one

// When searching, if the index is the end index, we will return true if the terminator property
// is true, otherwise false
// If the index is not the end index, we check the dictionary for the next character
// Or if the character is a '.', we will check all of the next character nodes

// MARK: - Solution

fileprivate class CharacterNode {
    
    var isTerminatingCharacter = false
    var nextNodes: [Character: CharacterNode] = [:]
    
    func link(characterAt index: String.Index, from word: String) {
        guard index < word.endIndex else {
            isTerminatingCharacter = true
            return
        }
        
        let character = word[index]
        
        if nextNodes[character] == nil { nextNodes[character] = CharacterNode() }
        
        nextNodes[character]!.link(characterAt: word.index(after: index), from: word)
    }
    
    func searchWith(characterAt index: String.Index, from word: String) -> Bool {
        guard index < word.endIndex else {
            return isTerminatingCharacter
        }
        
        let character = word[index]
        
        if character == Character(".") {
            for node in nextNodes.values {
                if node.searchWith(characterAt: word.index(after: index), from: word) {
                    return true
                }
            }
        } else if let node = nextNodes[character] {
            return node.searchWith(characterAt: word.index(after: index), from: word)
        }
        
        return false
    }
}

private class WordDictionary {
    
    let entryNode = CharacterNode()
    
    /** Adds a word into the data structure. */
    func addWord(_ word: String) {
        entryNode.link(characterAt: word.startIndex, from: word)
    }
    
    /** Returns if the word is in the data structure. A word could contain the dot character '.' to represent any one letter. */
    func search(_ word: String) -> Bool {
        return entryNode.searchWith(characterAt: word.startIndex, from: word)
    }
}

// MARK: - Tests

class WordDictionaryTests: XCTestCase {

    func test_WordDictionary_afterInsertingHello_containsHello() {
        // given
        let sut = WordDictionary()
        
        // when
        sut.addWord("hello")
        
        // then
        XCTAssertTrue(sut.search("hello"))
    }
    
    func test_WordDictionary_afterInsertingHello_doesNotContainYello() {
        // given
        let sut = WordDictionary()
        
        // when
        sut.addWord("hello")
        
        // then
        XCTAssertFalse(sut.search("yello"))
    }
    
    func testFuzzySearch() {
        // given
        let sut = WordDictionary()
        
        // when
        sut.addWord("hello")
        
        // then
        XCTAssertTrue(sut.search("h.l.o"))
    }
    
    func test_searchWithMultipleTerms() {
        // given
        let sut = WordDictionary()
        
        // when
        sut.addWord("dog")
        sut.addWord("cat")
        sut.addWord("mouse")
        sut.addWord("ant")
        sut.addWord("horse")
        sut.addWord("fly")
        sut.addWord("tick")
        sut.addWord("fish")
        
        // then
        XCTAssertTrue(sut.search("fly"))
    }
    
    func test_fuzzySearchWithMultipleTerms() {
        // given
        let sut = WordDictionary()
        
        // when
        sut.addWord("dog")
        sut.addWord("cat")
        sut.addWord("mouse")
        sut.addWord("ant")
        sut.addWord("horse")
        sut.addWord("fly")
        sut.addWord("tick")
        sut.addWord("fish")
        
        // then
        XCTAssertTrue(sut.search(".or.e"))
    }
    
    func test_fuzzySearchWithMultipleTerms2() {
        // given
        let sut = WordDictionary()
        
        // when
        sut.addWord("dog")
        sut.addWord("cat")
        sut.addWord("mouse")
        sut.addWord("ant")
        sut.addWord("horse")
        sut.addWord("fly")
        sut.addWord("tick")
        sut.addWord("fish")
        
        // then
        XCTAssertTrue(sut.search("mous."))
    }
    
    func test_WordDictionary_afterInsertingTerms_doesNotContainHello() {
        // given
        let sut = WordDictionary()
        
        // when
        sut.addWord("dog")
        sut.addWord("cat")
        sut.addWord("mouse")
        sut.addWord("ant")
        sut.addWord("horse")
        sut.addWord("fly")
        sut.addWord("tick")
        sut.addWord("fish")
        
        // then
        XCTAssertFalse(sut.search("hello"))
    }
    
    func test_WordDictionary_afterInsertingTerms_doesNotContainEmptyString() {
        // given
        let sut = WordDictionary()
        
        // when
        sut.addWord("dog")
        sut.addWord("cat")
        sut.addWord("mouse")
        sut.addWord("ant")
        sut.addWord("horse")
        sut.addWord("fly")
        sut.addWord("tick")
        sut.addWord("fish")
        
        // then
        XCTAssertFalse(sut.search(""))
    }
    
    func test_WordDictionary_afterInsertingTerms_doesNotContainPad() {
        // given
        let sut = WordDictionary()
        
        // when
        sut.addWord("add")
        sut.addWord("dad")
        sut.addWord("mad")
        
        // then
        XCTAssertFalse(sut.search("pad"))
    }
    
    func test_WordDictionary_afterInserting_a_and_ab() {
        // given
        let sut = WordDictionary()
        
        // when
        sut.addWord("a")
        sut.addWord("ab")
        
        // then
        XCTAssertTrue(sut.search("a."))
        XCTAssertTrue(sut.search("ab"))
    }
    
    func test_search_afterInserting_ran_rune_runner_runs() {
        // given
        let sut = WordDictionary()
        
        // when
        sut.addWord("ran")
        sut.addWord("rune")
        sut.addWord("runner")
        sut.addWord("runs")

        // then
        XCTAssertFalse(sut.search(".an."))
    }

}

