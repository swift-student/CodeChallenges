//
//  PrintLastLines.swift
//  CodeChallengesTests
//
//  Created by Shawn Gee on 9/29/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import XCTest

// MARK: - Challenge
// Paul Hudson's Swift Coding Challenges

//Challenge 27: Print last lines
//Difficulty: Easy
//Write a function that accepts a filename on disk, then prints its last N lines in reverse order, all
//on a single line separated by commas.
//Sample input and output
//Here is your test input file:
//Antony And Cleopatra
//Coriolanus
//Cymbeline
//Hamlet
//Julius Caesar
//King Lear
//Macbeth
//Othello
//Twelfth Night
//• If asked to print the last 3 lines, your code should output “Twelfth Night, Othello, Macbeth”.
//• If asked to print the last 100 lines, your code should output “Twelfth Night, Othello, Macbeth, King Lear, Julius Caesar, Hamlet, Cymbeline, Coriolanus, Antony and Cleopatra”.
//• If asked to print the last 0 lines, your could should print nothing.

// MARK: - Plan

// Look for the file on disk, and attempt to open it
// The function will throw if it can not open a file with that name
// Once opened, I need to get the contents into an array
// Then I can reverse the array and print N elements, separated by commas

// MARK: - Solution

private func printLast(nLines n: Int, of fileName: String) throws {
    let bundle = Bundle(for: PrintLastLinesTests.self)
    guard let fileURL = bundle.url(forResource: fileName, withExtension: ".txt") else {
        throw NSError(domain: "Could not open file with name \(fileName), no such file.", code: 0)
    }
    let lines = try String(contentsOf: fileURL)
        .split(separator: "\n")
        .reversed()
    print(lines.prefix(n).joined(separator: ", "))
}

// MARK: - Tests

class PrintLastLinesTests: XCTestCase {
    private let filename = "PrintLastLines"
    
    func testPrintLast3Lines() throws {
        try printLast(nLines: 3, of: filename)
    }
    
    func testPrintLast100Lines() throws {
        try printLast(nLines: 100, of: filename)
    }
    
    func testPrintLast0Lines() throws {
        try printLast(nLines: 0, of: filename)
    }
}
