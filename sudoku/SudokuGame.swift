//
//  SudokuGame.swift
//  sudoku
//
//  Created by Johnny Sparks  on 12/10/18.
//  Copyright © 2018 Johnny Sparks . All rights reserved.
//

import Foundation

class SudokuGame {

    enum Difficulty: Int {
        case hard = 10
        case normal = 20
        case easy = 30
    }

    static func generateGame(difficulty: Difficulty) -> SudokuGrid {
        var grid = SudokuGrid()
        var i = 0
        while i < difficulty.rawValue {
            let x = Int.random(in: 0..<grid.size)
            let y = Int.random(in: 0..<grid.size)
            let num = Int.random(in: 1...grid.size)
            let pos = Position(x: x, y: y)

            if grid.isSmart(move: Move(player: .game, val: num), at: pos) {
                grid.set(move: Move(player: .game, val: num), pos: pos)
                i += 1
            }
        }



        return grid
    }

    static func generateSolvedGame(difficulty: Difficulty) -> SudokuGrid {
        // TODO - pickup here
        // strategy
        // go through and randomly select a position in each row
        // starting one number at a time
        // if there's an unsolvable postion, (reset the number)?

        var grid = SudokuGrid()
        var val = 1
        var valFails = 0
        while val <= grid.size {
            var row = 0
            var rowFails = 0
            var cols = Array(0..<grid.size).shuffled()
            while !cols.isEmpty {
                let col = cols.popLast()!
                let pos = Position(x: col, y: row)
                let move = Move(player: .game, val: val)
                if grid.isSmart(move: move, at: pos) {
                    grid.set(move: move, pos: pos)
                    row += 1
                } else {
                    cols.insert(col, at: 0)
                    rowFails += 1
                    if rowFails > 50 {
                        grid.clear(all: move)
                        rowFails = 0
                        row = 0
                        cols = Array(0..<grid.size).shuffled()
                        valFails += 1
                        if valFails > 50 {
                            val -= 1
                            grid.clear(all: Move(player: .game, val: val))
                            valFails = 0
                        }
                    }
                }
            }
            val += 1
        }

        return grid
    }
}
