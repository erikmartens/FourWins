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

extension Sequence {
    func count(while predicate: (Element) throws -> Bool) rethrows -> Int {
        var count = 0
        for element in self {
            if try predicate(element) {
                count += 1
            } else {
                break
            }
        }
        return count
    }
}

extension RandomAccessCollection where Element: RandomAccessCollection, Index == Int, Element.Index == Int {
    fileprivate func elements(from start: Position, in direction: Direction) -> LazyMapSequence<UnfoldSequence<Position, (Position?, Bool)>, Self.Element.Element?>{
        let indices = sequence(first: start) { $0 + direction }
        return indices.lazy
            .map({ self[safe: $0.x]?[safe: $0.y] })
    }
    
}
extension RandomAccessCollection where
    Element: RandomAccessCollection,
    Index == Int,
    Element.Index == Int,
    Element.Element: Equatable
{
    fileprivate func connectedElementCount(on line: Line) -> Int {
        guard let element = self[safe: line.start.x]?[safe: line.start.y] else { return 0 }
        return 1 +
            elements(from: line.start, in: line.direction).dropFirst().count(while: { $0 == element }) +
            elements(from: line.start, in: line.direction.inverted).dropFirst().count(while: { $0 == element })
    }
}

extension Array where Element == Chip? {
    fileprivate func connectChipCount(for player: Chip, at insertionPoint: Int) -> Int {
        let lhsRowCount = self[0..<insertionPoint]
            .reversed()
            .count(while: { $0 == player })
        let rhsRowCount = self[insertionPoint...]
            .count(while: { $0 == player })
    
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
    
    private func checkDiagonalWin(for player: Chip, at column: Int) -> Bool {
        let y = columnStacks[column].count - 1
        let start = Position(column, y)
        let bottomLeftToTopRight = Line(start: start, direction: Direction(1, 1))
        let topLeftToBottomRight = Line(start: start, direction: Direction(1, -1))
        return columnStacks.connectedElementCount(on: bottomLeftToTopRight) >= FourWinsField.chipWinCount ||
            columnStacks.connectedElementCount(on: topLeftToBottomRight) >= FourWinsField.chipWinCount
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
