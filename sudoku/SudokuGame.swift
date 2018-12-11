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
        case easy = 60
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
}
