//
//  FourWinsTests.swift
//  FourWinsTests
//
//  Created by Erik Maximilian Martens on 20.11.18.
//  Copyright © 2018 Erik Maximilian Martens. All rights reserved.
//

import XCTest
@testable import FourWins

fileprivate let 🧑🏾: Chip = .player1
fileprivate let 👩: Chip = .player2
fileprivate let 👤: Chip? = nil

extension FourWinsField {
    fileprivate convenience init(_ field: [[Chip?]]) {
        self.init()
        field.reversed().forEach { (chips) in
            for (column, chip) in chips.enumerated() {
                if let chip = chip {
                    XCTAssertEqual(try? throwChip(player: chip, column: column), .nextTurn)
                }
            }
        }
    }
}

class FourWinsTests: XCTestCase {

    func testFirstTurn() {
        let fourWinsField = FourWinsField()
        XCTAssertEqual(try? fourWinsField.throwChip(player: 🧑🏾, column: 0), .nextTurn)
    }
    
    func testPlayerWonVerticalRow_fromFirstIndex() {
        let fourWinsField = FourWinsField()
        XCTAssertEqual(try? fourWinsField.throwChip(player: 🧑🏾, column: 0), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: 🧑🏾, column: 0), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: 🧑🏾, column: 0), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: 🧑🏾, column: 0), .won(🧑🏾))
    }
    
    func testPlayerWonVerticalRow_fromLastPossibleIndex() {
        let fourWinsField = FourWinsField()
        XCTAssertEqual(try? fourWinsField.throwChip(player: 👩, column: 0), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: 👩, column: 0), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: 🧑🏾, column: 0), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: 🧑🏾, column: 0), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: 🧑🏾, column: 0), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: 🧑🏾, column: 0), .won(🧑🏾))
    }
    
    func testPlayerWonHorizontalRow_fromFirstIndex() {
        let fourWinsField = FourWinsField()
        XCTAssertEqual(try? fourWinsField.throwChip(player: 🧑🏾, column: 0), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: 🧑🏾, column: 1), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: 🧑🏾, column: 2), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: 🧑🏾, column: 3), .won(🧑🏾))
    }
    
    func testPlayerWonHorizontalRow_fromLastPossibleIndex() {
        let fourWinsField = FourWinsField()
        XCTAssertEqual(try? fourWinsField.throwChip(player: 👩, column: 0), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: 👩, column: 1), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: 👩, column: 2), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: 🧑🏾, column: 3), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: 🧑🏾, column: 4), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: 🧑🏾, column: 5), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: 🧑🏾, column: 6), .won(🧑🏾))
    }
    
    func testVerticalRowBroken_secondIndex() {
        let fourWinsField = FourWinsField()
        XCTAssertEqual(try? fourWinsField.throwChip(player: 🧑🏾, column: 0), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: 👩, column: 0), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: 🧑🏾, column: 0), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: 🧑🏾, column: 0), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: 🧑🏾, column: 0), .nextTurn)
    }
    
    func testHorizontalRowBroken_secondIndex() {
        let fourWinsField = FourWinsField()
        XCTAssertEqual(try? fourWinsField.throwChip(player: 🧑🏾, column: 0), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: 👩, column: 1), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: 🧑🏾, column: 2), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: 🧑🏾, column: 3), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: 🧑🏾, column: 4), .nextTurn)
    }
    
    func testColumnOverdlow() {
        let fourWinsField = FourWinsField()
        XCTAssertEqual(try? fourWinsField.throwChip(player: 🧑🏾, column: 0), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: 👩, column: 0), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: 🧑🏾, column: 0), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: 👩, column: 0), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: 🧑🏾, column: 0), .nextTurn)
        XCTAssertEqual(try? fourWinsField.throwChip(player: 👩, column: 0), .nextTurn)
        
        XCTAssertThrowsError(try fourWinsField.throwChip(player: 👩, column: 0))
    }
    
    func testColumnIndexOutOfBounds() {
        let fourWinsField = FourWinsField()
        XCTAssertNoThrow(try fourWinsField.throwChip(player: 🧑🏾, column: 0))
        XCTAssertNoThrow(try fourWinsField.throwChip(player: 🧑🏾, column: 6))
        XCTAssertThrowsError(try fourWinsField.throwChip(player: 🧑🏾, column: -1))
        XCTAssertThrowsError(try fourWinsField.throwChip(player: 🧑🏾, column: 7))
    }
    
    func testDiagonalWinBottemLeftToTopRight() {
        let fourWinsField = FourWinsField([
            [👤, 👤, 👤, 👤, 👤, 👤, 👤],
            [👤, 👤, 👤, 👤, 👤, 👤, 👤],
            [👤, 👤, 👤, 👤, 👤, 👤, 👤],
            [👤, 👤, 🧑🏾, 👩, 👤, 👤, 👤],
            [👤, 🧑🏾, 👩, 👩, 👤, 👤, 👤],
            [🧑🏾, 👩, 👩, 👩, 👤, 👤, 👤],
        ])
        XCTAssertEqual(try? fourWinsField.throwChip(player: 🧑🏾, column: 3), .won(🧑🏾))
        
    }
    func testDiagonalWinBottemRightToTopLeft() {
        let fourWinsField = FourWinsField([
            [👤, 👤, 👤, 👤, 👤, 👤, 👤],
            [👤, 👤, 👤, 👤, 👤, 👤, 👤],
            [👤, 👤, 👤, 👤, 👤, 👤, 👤],
            [👤, 👤, 👤, 👩, 🧑🏾, 👤, 👤],
            [👤, 👤, 👤, 👩, 👩, 🧑🏾, 👤],
            [👤, 👤, 👤, 👩, 👩, 👩, 🧑🏾],
        ])
        XCTAssertEqual(try? fourWinsField.throwChip(player: 🧑🏾, column: 3), .won(🧑🏾))
    }
    
    
    func testDiagonalWinTopLeftToBottomRight() {
        let fourWinsField = FourWinsField([
            [👤, 👤, 👤, 👤, 👤, 👤, 👤],
            [👤, 👤, 👤, 👤, 👤, 👤, 👤],
            [👤, 👤, 👤, 👤, 👤, 👤, 👤],
            [👩, 🧑🏾, 👤, 👤, 👤, 👤, 👤],
            [👩, 👩, 🧑🏾, 👤, 👤, 👤, 👤],
            [👩, 👩, 👩, 🧑🏾, 👤, 👤, 👤],
        ])
        XCTAssertEqual(try? fourWinsField.throwChip(player: 🧑🏾, column: 0), .won(🧑🏾))
    }
    func testDiagonalWinTopLeftToBottomRight2() {
        let fourWinsField = FourWinsField([
            [👤, 👤, 👤, 👤, 👤, 👤, 👤],
            [👩, 🧑🏾, 👤, 👤, 👤, 👤, 👤],
            [👩, 👩, 🧑🏾, 👤, 👤, 👤, 👤],
            [🧑🏾, 🧑🏾, 👩, 🧑🏾, 👤, 👤, 👤],
            [👩, 👩, 🧑🏾, 🧑🏾, 👤, 👤, 👤],
            [🧑🏾, 🧑🏾, 👩, 👩, 👤, 👤, 👤],
        ])
        XCTAssertEqual(try? fourWinsField.throwChip(player: 🧑🏾, column: 0), .won(🧑🏾))
    }
    func testDiagonalWinTopRightToBottomLeft() {
        let fourWinsField = FourWinsField([
            [👤, 👤, 👤, 👤, 👤, 👤, 👤],
            [👤, 👤, 👤, 👤, 👤, 👤, 👤],
            [👤, 👤, 👤, 👤, 👤, 👤, 👤],
            [👤, 👤, 👤, 👤, 👤, 👩, 🧑🏾],
            [👤, 👤, 👤, 👤, 👩, 👩, 🧑🏾],
            [👤, 👤, 👤, 👩, 👩, 👩, 🧑🏾],
        ])
        XCTAssertEqual(try? fourWinsField.throwChip(player: 👩, column: 6), .won(👩))
    }
    func testDiagonalWinTopRightToBottomLeft2() {
        let fourWinsField = FourWinsField([
            [👤, 👤, 👤, 👤, 👤, 👤, 👤],
            [👤, 👤, 👤, 👤, 👤, 👩, 🧑🏾],
            [👤, 👤, 👤, 👤, 👩, 👩, 🧑🏾],
            [👤, 👤, 👤, 👩, 👩, 🧑🏾, 👩],
            [👤, 👤, 👤, 🧑🏾, 🧑🏾, 👩, 🧑🏾],
            [👤, 👤, 👤, 👩, 👩, 🧑🏾, 🧑🏾],
        ])
        XCTAssertEqual(try? fourWinsField.throwChip(player: 👩, column: 6), .won(👩))
    }
}
