//
//  Position.swift
//  sudoku
//
//  Created by Johnny Sparks  on 12/9/18.
//  Copyright © 2018 Johnny Sparks . All rights reserved.
//

import Foundation

struct Position {
    let x: Int
    let y: Int
}

extension Position: Equatable {
    static func ==(lhs: Position, rhs: Position) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}

extension Position: Hashable {
    var hashValue: Int {
        return x.hashValue ^ y.hashValue
    }
}


extension IndexPath {
    func toPosition() -> Position {
        return Position(x: row, y: section)
    }
}
