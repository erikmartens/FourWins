//
//  Sequence+Extensions.swift
//  FourWins
//
//  Created by David Nadoba on 27.11.18.
//  Copyright © 2018 Erik Maximilian Martens. All rights reserved.
//

import Foundation

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
