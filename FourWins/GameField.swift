//
//  FourWinsField.swift
//  FourWins
//
//  Created by Erik Maximilian Martens on 20.11.18.
//  Copyright © 2018 Erik Maximilian Martens. All rights reserved.
//

import Foundation

enum Chip: Equatable {
    case player1
    case player2
}

enum Result: Equatable {
    case nextTurn
    case draw
    case won(Chip)
}

enum FourWinsLogicError: Error {
    case positionAlreadyInUse
    case columnStackOverflow
    case columnIndexOutOfBounds
    case columnRowIndexOutOfBounds
}

protocol TicTacToeLogic {
    mutating func setChip(player: Chip, row: Int, column: Int) throws -> Result
}

protocol FourWinsLogic {
    mutating func throwChip(player: Chip, column: Int) throws -> Result
}

class GameField {
    let columnHeight: Int
    let columnCount: Int
    let chipWinCount: Int
    var columnStacks: [[Chip?]]
    static func makeFourWin() -> GameField {
        return GameField(columnCount: 7, columnHeight: 6, chipWinCount: 4)
    }
    static func makeTicTacToe() -> GameField {
        return GameField(columnCount: 3, columnHeight: 3, chipWinCount: 3)
    }
    private init(columnCount: Int, columnHeight: Int, chipWinCount: Int) {
        self.columnCount = columnCount
        self.columnHeight = columnHeight
        self.chipWinCount = chipWinCount
        self.columnStacks = Array(repeating: Array(repeating: nil, count: columnHeight), count: columnCount)
    }
}

extension GameField {
    private func checkVerticalWin(for player: Chip, at column: Int, row: Int) -> Bool {
        let start = Position(column, row)
        let bottomToTop = Line(start: start, direction: Direction(0, 1))
        
        return columnStacks.connectedElementCount(on: bottomToTop) == chipWinCount
    }
    
    private func checkHorizontalWin(for player: Chip, at column: Int, row: Int) -> Bool {
        let start = Position(column, row)
        let leftToRight = Line(start: start, direction: Direction(1, 0))
        
        return columnStacks.connectedElementCount(on: leftToRight) == chipWinCount
    }
    
    private func checkDiagonalWin(for player: Chip, at column: Int, row: Int) -> Bool {
        let start = Position(column, row)
        let bottomLeftToTopRight = Line(start: start, direction: Direction(1, 1))
        let topLeftToBottomRight = Line(start: start, direction: Direction(1, -1))
        return columnStacks.connectedElementCount(on: bottomLeftToTopRight) >= chipWinCount ||
            columnStacks.connectedElementCount(on: topLeftToBottomRight) >= chipWinCount
    }
    fileprivate func checkForWin(_ player: Chip, column: Int, row: Int) -> Result {
        if checkVerticalWin(for: player, at: column, row: row)
            || checkHorizontalWin(for: player, at: column, row: row)
            || checkDiagonalWin(for: player, at: column, row: row) {
            return .won(player)
        }
        return .nextTurn
    }
}

extension GameField: FourWinsLogic {
    func throwChip(player: Chip, column: Int) throws -> Result {
        guard columnStacks.indices.contains(column) else {
            throw FourWinsLogicError.columnIndexOutOfBounds
        }
        guard let index = columnStacks[column].firstIndex(of: nil) else {
            throw FourWinsLogicError.columnStackOverflow
        }
        columnStacks[column][index] = player
        
        return checkForWin(player, column: column, row: index)
    }
}

extension GameField: TicTacToeLogic {
    
    func setChip(player: Chip, row: Int, column: Int) throws -> Result {
        guard columnStacks.indices.contains(column) else {
            throw FourWinsLogicError.columnIndexOutOfBounds
        }
        guard columnStacks[column].indices.contains(row) else {
            throw FourWinsLogicError.columnRowIndexOutOfBounds
        }
        guard columnStacks[column][row] == nil else {
            throw FourWinsLogicError.positionAlreadyInUse
        }
        columnStacks[column][row] = player
        
        return checkForWin(player, column: column, row: row)
    }
}

