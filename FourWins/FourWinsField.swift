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

extension RandomAccessCollection {
    subscript(safe index: Index) -> Element? {
        guard indices.contains(index) else { return nil }
        return self[index]
    }
}

extension Array where Element == Chip? {
    fileprivate func connectChipCount(for player: Chip, at insertionPoint: Int) -> Int {
        let lhsRowCount = self[0..<insertionPoint]
            .reversed()
            .prefix(while: { $0 == player })
            .count
        let rhsRowCount = self[insertionPoint...]
            .prefix(while: { $0 == player })
            .count
    
        return lhsRowCount + rhsRowCount
    }
}

extension FourWinsField: FourWinsLogic {
    
    private func checkVerticalWin(for player: Chip, at column: Int) -> Bool {
        let chipsInARow = columnStacks[column].reversed().prefix(while: { $0 == player })
        return chipsInARow.count == FourWinsField.chipWinCount
    }
    
    private func checkHorizontalWin(for player: Chip, at column: Int) -> Bool {
        let height = columnStacks[column].count - 1
        let row = columnStacks.map { $0[safe: height] }
        
        return row.connectChipCount(for: player, at: column) >= FourWinsField.chipWinCount
    }
    
    private func diagnoal(startX: Int, startY: Int) -> (lower: [Chip?], upper: [Chip?]) {
        let lowerMinX = startX - min(startX, startY)
        let minY = startY - min(startX, startY)
        let lowerRangeX = (lowerMinX..<FourWinsField.columnCount)
        let lowerRangeY = (minY..<FourWinsField.columnHeight)
        let lowerIndeces = zip(lowerRangeX, lowerRangeY)
        let lowerDiagonalRow = lowerIndeces.map { columnStacks[$0][safe: $1] }
        
        let upperMinX = FourWinsField.columnCount - max(startX, startY)
        let maxY = FourWinsField.columnHeight - 1 - min(startX, startY)
        let upperRangeX = (upperMinX..<FourWinsField.columnCount)
        let upperRangeY = (0..<maxY).reversed()
        let upperIndeces = zip(upperRangeX, upperRangeY)
        let upperDiagonalRow = upperIndeces.map { columnStacks[$0][safe: $1] }
        
        return (lowerDiagonalRow, upperDiagonalRow)
    }
    
    private func checkDiagonalWin(for player: Chip, at column: Int) -> Bool {
        let height = columnStacks[column].count - 1
        let lowerInsertionPoiunt = min(height, column)
        let upperInsertionPoiunt = min(FourWinsField.columnHeight - height - 1, column)
        let resultDiagonalRows =  diagnoal(startX: column, startY: height)
        
        return resultDiagonalRows.lower.connectChipCount(for: player, at: lowerInsertionPoiunt) >= FourWinsField.chipWinCount
            || resultDiagonalRows.upper.connectChipCount(for: player, at: upperInsertionPoiunt) >= FourWinsField.chipWinCount
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
            || checkHorizontalWin(for: player, at: column)
            || checkDiagonalWin(for: player, at: column) {
            return .won(player)
        }
        return .nextTurn
    }
}
