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
        let easy = SudokuGame.generateGame(difficulty: .easy).nums.map { $0.val }
        let normal = SudokuGame.generateGame(difficulty: .normal).nums.map { $0.val }
        let hard = SudokuGame.generateGame(difficulty: .hard).nums.map { $0.val }

        XCTAssertEqual(easy.compactMap({ $0 }).count, SudokuGame.Difficulty.easy.rawValue)
        XCTAssertEqual(normal.compactMap({ $0 }).count, SudokuGame.Difficulty.normal.rawValue)
        XCTAssertEqual(hard.compactMap({ $0 }).count, SudokuGame.Difficulty.hard.rawValue)
    }

    func testSolvedGame() {
        let grid = SudokuGame.generateSolvedGame(difficulty: .easy).nums.map { $0.val }
        XCTAssertEqual(grid.compactMap({ $0 }).count, grid.count)
    }
}
