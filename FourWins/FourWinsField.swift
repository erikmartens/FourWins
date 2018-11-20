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
    case columnStackOverflow
    case columnIndexOutOfBounds
}

protocol FourWinsLogic {
    mutating func throwChip(player: Chip, column: Int) throws -> Result
}

class FourWinsField {
    static let columnHeight = 6
    static let columnCount = 7
    static let chipWinCount = 4
    var columnStacks = Array(repeating: Array<Chip>(), count: FourWinsField.columnCount)
}

extension FourWinsField: FourWinsLogic {
    
    private func checkVerticalWin(for player: Chip, at column: Int) -> Bool {
        let chipsInARow = columnStacks[column].reversed().prefix(while: { $0 == player })
        return chipsInARow.count == FourWinsField.chipWinCount
    }
    
    private func checkHorizontalWin(for player: Chip, at column: Int) -> Bool {
        let height = columnStacks[column].count - 1
        let row = columnStacks.map { column -> Chip? in
            guard column.indices.contains(height) else {
                return nil
            }
            return column[height]
        }
        
        let lhsRowCount = row[0..<column]
            .reversed()
            .prefix(while: { $0 == player })
            .count
        let rhsRowCount = row[column...]
            .prefix(while: { $0 == player })
            .count
        
        return lhsRowCount + rhsRowCount >= 4
    }
    
    func throwChip(player: Chip, column: Int) throws -> Result {
        guard columnStacks.indices.contains(column) else {
            throw FourWinsLogicError.columnIndexOutOfBounds
        }
        if columnStacks[column].count >= FourWinsField.columnHeight {
            throw FourWinsLogicError.columnStackOverflow
        }
        
        columnStacks[column].append(player)
        if checkVerticalWin(for: player, at: column)
            || checkHorizontalWin(for: player, at: column) {
            return .won(player)
        }
        return .nextTurn
    }
}
