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
    
    func testPlayerWonVerticalRow_fromFirstIndex() {
        let fourWinsField = FourWinsField()
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player1, column: 0), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player1, column: 0), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player1, column: 0), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player1, column: 0), .won(.player1))
    }
    
    func testPlayerWonVerticalRow_fromLastPossibleIndex() {
        let fourWinsField = FourWinsField()
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player2, column: 0), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player2, column: 0), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player1, column: 0), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player1, column: 0), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player1, column: 0), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player1, column: 0), .won(.player1))
    }
    
    func testPlayerWonHorizontalRow_fromFirstIndex() {
        let fourWinsField = FourWinsField()
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player1, column: 0), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player1, column: 1), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player1, column: 2), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player1, column: 3), .won(.player1))
    }
    
    func testPlayerWonHorizontalRow_fromLastPossibleIndex() {
        let fourWinsField = FourWinsField()
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player2, column: 0), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player2, column: 1), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player2, column: 2), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player1, column: 3), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player1, column: 4), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player1, column: 5), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player1, column: 6), .won(.player1))
    }
    
    func testVerticalRowBroken_secondIndex() {
        let fourWinsField = FourWinsField()
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player1, column: 0), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player2, column: 0), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player1, column: 0), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player1, column: 0), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player1, column: 0), .nextTurn)
    }
    
    func testHorizontalRowBroken_secondIndex() {
        let fourWinsField = FourWinsField()
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player1, column: 0), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player2, column: 1), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player1, column: 2), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player1, column: 3), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player1, column: 4), .nextTurn)
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
    
    func testDiagonalWinBottemLeftToTopRight() {
        let fourWinsField = FourWinsField()
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player1, column: 0), .nextTurn)
        
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player2, column: 1), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player1, column: 1), .nextTurn)
        
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player2, column: 2), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player2, column: 2), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player1, column: 2), .nextTurn)
        
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player2, column: 3), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player2, column: 3), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player2, column: 3), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player1, column: 3), .won(.player1))
        
    }
    func testDiagonalWinBottemRightToTopLeft() {
        let fourWinsField = FourWinsField()
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player1, column: 6), .nextTurn)
        
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player2, column: 5), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player1, column: 5), .nextTurn)
        
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player2, column: 4), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player2, column: 4), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player1, column: 4), .nextTurn)
        
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player2, column: 3), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player2, column: 3), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player2, column: 3), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: .player1, column: 3), .won(.player1))
        
    }
}
