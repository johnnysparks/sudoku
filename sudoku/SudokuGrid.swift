//
//  SudokuGrid.swift
//  sudoku
//
//  Created by Johnny Sparks  on 12/9/18.
//  Copyright © 2018 Johnny Sparks . All rights reserved.
//

import Foundation

enum SetType: CaseIterable {
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

extension Move: Equatable {
    static func ==(lhs: Move, rhs: Move) -> Bool {
        return lhs.player == rhs.player && lhs.val == rhs.val
    }
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
        return (
            isLegal(move: move, at: pos) &&
            isSetSafe(move: move, forNth: pos.y, set: .row) &&
            isSetSafe(move: move, forNth: pos.x, set: .column) &&
            isSetSafe(move: move, forNth: grid(for: pos), set: .grid)
        )
    }

    func isSetSafe(move: Move, forNth nth: Int, set: SetType) -> Bool {
        guard let val = move.val else {
            return true
        }

        return !numbersFor(nth: nth, set: set).contains(val)
    }

    mutating func clear(all move: Move) {
        for idx in 0..<size*size {
            if nums[idx] == move {
                nums[idx] = .none
            }
        }
    }

    @discardableResult
    mutating func removeRandom(player: Player) -> Move? {
        let max = nums.filter({ $0 != .none }).count
        guard max > 0 else {
            return nil
        }

        let target = Int.random(in: 0..<max)
        var current = 0
        for idx in 0..<nums.count {
            let move = nums[idx]
            if move != .none {
                if current == target {
                    nums[idx] = .none
                    return move
                }
                current += 1
            }
        }
        return nil
    }

    func isComplete() -> Bool {
        let allNums = Set<Int>(Array(1...size))
        for set in SetType.allCases {
            for nth in 0..<size {
                let nums = Set(numbersFor(nth: nth, set: set))
                if nums != allNums {
                    return false
                }
            }
        }

        return true
    }
}

extension SudokuGrid: CustomStringConvertible {
    var description: String {
        var out = ""
        for y in 0..<size {
            for x in 0..<size {
                if let n = number(at: Position(x: x, y: y)) {
                    out += "\(n)"
                } else {
                    out += "."
                }
            }
            out += "\n"
        }
        return out
    }
}
