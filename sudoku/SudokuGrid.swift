//
//  SudokuGrid.swift
//  sudoku
//
//  Created by Johnny Sparks  on 12/9/18.
//  Copyright © 2018 Johnny Sparks . All rights reserved.
//

import Foundation

enum SetType {
    case row
    case column
    case grid
}

enum Player: Int {
    case none = 0
    case user = 1
    case game = 2
}

struct Move {
    let player: Player
    let val: Int?
    
    static let none = Move(player: .none, val: nil)
}

struct SudokuGrid {
    let size: Int = 9

    var nums: [Move] = Array(repeating: Move.none, count: 81)

    mutating func set(move: Move, pos: Position) {
        let idx = pos.x + pos.y * size
        nums[idx] = move
    }

    func number(at pos: Position) -> Int? {
        let idx = pos.x + pos.y * size
        return nums[idx].val
    }

    func move(at pos: Position) -> Move {
        let idx = pos.x + pos.y * size
        return nums[idx]
    }

    func postionsFor(nth: Int, set: SetType) -> [Position] {
        switch set {
        case .row:
            let cols = Array(0..<size)
            return cols.map({ Position(x: $0, y: nth) })
        case .column:
            let rows = Array(0..<size)
            return rows.map({ Position(x: nth, y: $0) })
        case .grid:
            let miniSize = Int(sqrt(Double(size)))
            let col = (nth % miniSize) * miniSize
            let row = (nth / miniSize) * miniSize
            return (col..<col + miniSize).flatMap({ x in
                return (row..<row + miniSize).map({ y in
                    return Position(x: x, y: y)
                })
            })
        }
    }

    func numbersFor(nth: Int, set: SetType) -> Set<Int> {
        return Set(postionsFor(nth: nth, set: set).compactMap({ number(at: $0 )}))
    }

    func grid(for position: Position) -> Int {
        let miniSize = Int(sqrt(Double(size)))

        let topY = position.y / miniSize
        let leftX = position.x / miniSize

        return topY * miniSize + leftX
    }

    func isLegal(move: Move, at pos: Position) -> Bool {
        if self.move(at: pos).player == .game {
            return false
        }

        return true
    }

    func isSmart(move: Move, at pos: Position) -> Bool {
        let isSafe = (
            isSetSafe(move: move, forNth: pos.y, set: .row) &&
            isSetSafe(move: move, forNth: pos.x, set: .column) &&
            isSetSafe(move: move, forNth: grid(for: pos), set: .grid)
        )

        return isSafe && isLegal(move: move, at: pos)
    }

    func isSetSafe(move: Move, forNth nth: Int, set: SetType) -> Bool {
        guard let val = move.val else {
            return true
        }

        return !numbersFor(nth: nth, set: set).contains(val)
    }
}

