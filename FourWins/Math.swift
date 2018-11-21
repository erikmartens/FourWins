//
//  Math.swift
//  FourWins
//
//  Created by David Nadoba on 21.11.18.
//  Copyright © 2018 Erik Maximilian Martens. All rights reserved.
//

import Foundation

struct Position {
    var x: Int
    var y: Int
    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
}

extension Position {
    static func +(lhs: Position, rhs: Direction) -> Position {
        return Position(lhs.x + rhs.x, lhs.y + rhs.y)
    }
}

struct Direction {
    var x: Int
    var y: Int
    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
}

extension Direction {
    var inverted: Direction { return Direction(-x, -y) }
}

struct Line {
    var start: Position
    var direction: Direction
}
