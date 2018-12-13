//
//  SudokuGameTests.swift
//  sudokuTests
//
//  Created by Johnny Sparks  on 12/10/18.
//  Copyright © 2018 Johnny Sparks . All rights reserved.
//

import XCTest
@testable import sudoku

class SudokuGameTests: XCTestCase {

    func testGenerateGame() {
        let easy = SudokuGame.generateGame(difficulty: .easy)
        let normal = SudokuGame.generateGame(difficulty: .normal)
        let hard = SudokuGame.generateGame(difficulty: .hard)
        XCTAssertEqual(easy.nums.filter({ $0 != .none }).count,
                       SudokuGame.Difficulty.easy.rawValue)
        XCTAssertEqual(normal.nums.filter({ $0 != .none }).count,
                       SudokuGame.Difficulty.normal.rawValue)
        XCTAssertEqual(hard.nums.filter({ $0 != .none }).count,
                       SudokuGame.Difficulty.hard.rawValue)
    }

    func testSolvedGame() {
        let grid = SudokuGame.generateSolvedGame().nums.map { $0.val }
        XCTAssertEqual(grid.compactMap({ $0 }).count, grid.count)
    }
}
