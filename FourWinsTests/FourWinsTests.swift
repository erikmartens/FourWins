//
//  FourWinsTests.swift
//  FourWinsTests
//
//  Created by Erik Maximilian Martens on 20.11.18.
//  Copyright © 2018 Erik Maximilian Martens. All rights reserved.
//

import XCTest
@testable import FourWins

class FourWinsTests: XCTestCase {

    func testFirstTurn() {
        let fourWinsField = FourWinsField()
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player1, column: 0), .nextTurn)
    }
    
    func testVerticalRow_fromFirstIndex() {
        let fourWinsField = FourWinsField()
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player1, column: 0), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player1, column: 0), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player1, column: 0), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player1, column: 0), .won(.player1))
    }
    
    func testVerticalRow_fromLastPossibleIndex() {
        let fourWinsField = FourWinsField()
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player2, column: 0), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player2, column: 0), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player1, column: 0), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player1, column: 0), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player1, column: 0), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player1, column: 0), .won(.player1))
    }
    
    func testVerticalRowBroken_secondIndex() {
        let fourWinsField = FourWinsField()
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player1, column: 0), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player2, column: 0), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player1, column: 0), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player1, column: 0), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player1, column: 0), .nextTurn)
    }
    
    func testColumnOverdlow() {
        let fourWinsField = FourWinsField()
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player1, column: 0), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player2, column: 0), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player1, column: 0), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player2, column: 0), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player1, column: 0), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player2, column: 0), .nextTurn)
        
        XCTAssertThrowsError(try fourWinsField.throwChip(player: .player2, column: 0))
    }
    func testColumnIndexOutOfBounds() {
        let fourWinsField = FourWinsField()
        XCTAssertNoThrow(try fourWinsField.throwChip(player: .player1, column: 0))
        XCTAssertNoThrow(try fourWinsField.throwChip(player: .player1, column: 6))
        XCTAssertThrowsError(try fourWinsField.throwChip(player: .player1, column: -1))
        XCTAssertThrowsError(try fourWinsField.throwChip(player: .player1, column: 7))
    }
}
