//
//  TicTacToeTests.swift
//  FourWinsTests
//
//  Created by David Nadoba on 27.11.18.
//  Copyright © 2018 Erik Maximilian Martens. All rights reserved.
//

import XCTest
@testable import FourWins

fileprivate let 🧑🏾: Chip = .player1
fileprivate let 👩: Chip = .player2
fileprivate let 👤: Chip? = nil

extension GameField {
    fileprivate static func makeTicTacToe(_ field: [[Chip?]]) -> GameField {
        let fourWinsField = GameField.makeTicTacToe()
        field.reversed().enumerated().forEach { (row, chips) in
            for (column, chip) in chips.enumerated() {
                if let chip = chip {
                    XCTAssertEqual(try? fourWinsField.setChip(player: chip, row: row, column: column), .nextTurn)
                }
            }
        }
        return fourWinsField
    }
}

class TicTacToeTests: XCTestCase {

    func testFirstTurn() {
        let ticTacToeField = GameField.makeTicTacToe()
        XCTAssertEqual(try? ticTacToeField.setChip(player: 🧑🏾, row: 0, column: 0), .nextTurn)
    }
    
    func testHorzontalRow1() {
        let ticTacToeField = GameField.makeTicTacToe([
                [🧑🏾, 🧑🏾, 👤],
                [👤, 👤, 👤],
                [👤, 👤, 👤],
        ])
        XCTAssertEqual(try? ticTacToeField.setChip(player: 🧑🏾, row: 2, column: 2), .won(🧑🏾))
    }
    func testHorzontalRow2() {
        let ticTacToeField = GameField.makeTicTacToe([
            [👤, 👤, 👤],
            [🧑🏾, 🧑🏾, 👤],
            [👤, 👤, 👤],
            ])
        XCTAssertEqual(try? ticTacToeField.setChip(player: 🧑🏾, row: 1, column: 2), .won(🧑🏾))
    }
    func testHorzontalRow3() {
        let ticTacToeField = GameField.makeTicTacToe([
            [👤, 👤, 👤],
            [👤, 👤, 👤],
            [🧑🏾, 🧑🏾, 👤],
            ])
        XCTAssertEqual(try? ticTacToeField.setChip(player: 🧑🏾, row: 0, column: 2), .won(🧑🏾))
    }
    func testVerticalRow1() {
        let ticTacToeField = GameField.makeTicTacToe([
            [👤, 👤, 👤],
            [🧑🏾, 👤, 👤],
            [🧑🏾, 👤, 👤],
            ])
        XCTAssertEqual(try? ticTacToeField.setChip(player: 🧑🏾, row: 2, column: 0), .won(🧑🏾))
    }
    func testVerticalRow2() {
        let ticTacToeField = GameField.makeTicTacToe([
            [👤, 👤, 👤],
            [👤, 🧑🏾, 👤],
            [👤, 🧑🏾, 👤],
            ])
        XCTAssertEqual(try? ticTacToeField.setChip(player: 🧑🏾, row: 2, column: 1), .won(🧑🏾))
    }
    func testVerticalRow3() {
        let ticTacToeField = GameField.makeTicTacToe([
            [👤, 👤, 👤],
            [👤, 👤, 🧑🏾],
            [👤, 👤, 🧑🏾],
            ])
        XCTAssertEqual(try? ticTacToeField.setChip(player: 🧑🏾, row: 2, column: 2), .won(🧑🏾))
    }
    func testDiagonal1() {
        let ticTacToeField = GameField.makeTicTacToe([
            [👤, 👤, 👤],
            [👤, 🧑🏾, 👤],
            [👤, 👤, 🧑🏾],
            ])
        XCTAssertEqual(try? ticTacToeField.setChip(player: 🧑🏾, row: 2, column: 0), .won(🧑🏾))
    }
    func testDiagonal2() {
        let ticTacToeField = GameField.makeTicTacToe([
            [👤, 👤, 👤],
            [👤, 🧑🏾, 👤],
            [🧑🏾, 👤, 👤],
            ])
        XCTAssertEqual(try? ticTacToeField.setChip(player: 🧑🏾, row: 2, column: 2), .won(🧑🏾))
    }
}
