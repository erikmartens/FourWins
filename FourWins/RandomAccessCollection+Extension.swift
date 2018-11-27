//
//  RandomAccessCollection+Extension.swift
//  FourWins
//
//  Created by David Nadoba on 27.11.18.
//  Copyright © 2018 Erik Maximilian Martens. All rights reserved.
//

import Foundation

extension RandomAccessCollection {
    subscript(safe index: Index) -> Element? {
        guard indices.contains(index) else { return nil }
        return self[index]
    }
}

extension RandomAccessCollection where Element: RandomAccessCollection, Index == Int, Element.Index == Int {
    func elements(from start: Position, in direction: Direction) -> LazyMapSequence<UnfoldSequence<Position, (Position?, Bool)>, Self.Element.Element?>{
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
    func connectedElementCount(on line: Line) -> Int {
        guard let element = self[safe: line.start.x]?[safe: line.start.y] else { return 0 }
        return 1 +
            elements(from: line.start, in: line.direction).dropFirst().count(while: { $0 == element }) +
            elements(from: line.start, in: line.direction.inverted).dropFirst().count(while: { $0 == element })
    }
}
