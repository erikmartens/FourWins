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
    
    private func checkHorizontal(for player: Chip, at column: Int) -> Bool {
        let chipsInARow = columnStacks[column].reversed().prefix(while: { $0 == player })
        return chipsInARow.count == FourWinsField.chipWinCount
    }
    
    func throwChip(player: Chip, column: Int) throws -> Result {
        guard columnStacks.indices.contains(column) else {
            throw FourWinsLogicError.columnIndexOutOfBounds
        }
        if columnStacks[column].count >= FourWinsField.columnHeight {
            throw FourWinsLogicError.columnStackOverflow
        }
        
        columnStacks[column].append(player)
        if checkHorizontal(for: player, at: column) {
            return .won(player)
        }
        return .nextTurn
    }
}
