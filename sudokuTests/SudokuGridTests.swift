//
//  sudoku_visionTests.swift
//  sudoku-visionTests
//
//  Created by Johnny Sparks  on 12/8/18.
//  Copyright © 2018 Johnny Sparks . All rights reserved.
//

import XCTest
@testable import sudoku

class SudokuGridTests: XCTestCase {
    //MARK: - Positions
    func testPositionsForRow() {

        let positions: Set<Position> = Set([
            Position(x: 0, y: 1),
            Position(x: 1, y: 1),
            Position(x: 2, y: 1),
            Position(x: 3, y: 1),
            Position(x: 4, y: 1),
            Position(x: 5, y: 1),
            Position(x: 6, y: 1),
            Position(x: 7, y: 1),
            Position(x: 8, y: 1),
        ])

        let rowPositions = Set(SudokuGrid().postionsFor(nth: 1, set: .row))
        XCTAssert(positions.elementsEqual(rowPositions))
    }

    func testPositionsForCol() {
        let positions: Set<Position> = Set([
            Position(x: 4, y: 0),
            Position(x: 4, y: 1),
            Position(x: 4, y: 2),
            Position(x: 4, y: 3),
            Position(x: 4, y: 4),
            Position(x: 4, y: 5),
            Position(x: 4, y: 6),
            Position(x: 4, y: 7),
            Position(x: 4, y: 8),
            ])

        let rowPositions = Set(SudokuGrid().postionsFor(nth: 4, set: .column))
        XCTAssert(positions.elementsEqual(rowPositions))
    }

    func testPositionsForGrid() {
        let positions: Set<Position> = Set([
            Position(x: 3, y: 3),
            Position(x: 3, y: 4),
            Position(x: 3, y: 5),
            Position(x: 4, y: 3),
            Position(x: 4, y: 4),
            Position(x: 4, y: 5),
            Position(x: 5, y: 3),
            Position(x: 5, y: 4),
            Position(x: 5, y: 5),
            ])

        let rowPositions = Set(SudokuGrid().postionsFor(nth: 4, set: .grid))
        XCTAssert(positions.elementsEqual(rowPositions))
    }


    //MARK: - Number
    func testNumbersForRow() {
        var grid = SudokuGrid()
        grid.set(move: .game(1), pos: Position(x: 3, y: 3))
        grid.set(move: .game(2), pos: Position(x: 3, y: 4))
        grid.set(move: .game(3), pos: Position(x: 3, y: 5))
        grid.set(move: .game(4), pos: Position(x: 4, y: 3))
        grid.set(move: .game(5), pos: Position(x: 4, y: 4))
        grid.set(move: .game(6), pos: Position(x: 4, y: 5))
        grid.set(move: .game(7), pos: Position(x: 5, y: 3))
        grid.set(move: .game(8), pos: Position(x: 5, y: 4))
        grid.set(move: .game(9), pos: Position(x: 5, y: 5))
        var nums = grid.numbersFor(nth: 3, set: .row)
        XCTAssert(Set([1, 4, 7]).elementsEqual(nums))

        nums = grid.numbersFor(nth: 4, set: .row)
        XCTAssert(Set([2, 5, 8]).elementsEqual(nums))

        nums = grid.numbersFor(nth: 5, set: .row)
        XCTAssert(Set([3, 6, 9]).elementsEqual(nums))
    }

    func testNumbersForColumn() {
        var grid = SudokuGrid()
        grid.set(move: .game(1), pos: Position(x: 3, y: 3))
        grid.set(move: .game(2), pos: Position(x: 3, y: 4))
        grid.set(move: .game(3), pos: Position(x: 3, y: 5))
        grid.set(move: .game(4), pos: Position(x: 4, y: 3))
        grid.set(move: .game(5), pos: Position(x: 4, y: 4))
        grid.set(move: .game(6), pos: Position(x: 4, y: 5))
        grid.set(move: .game(7), pos: Position(x: 5, y: 3))
        grid.set(move: .game(8), pos: Position(x: 5, y: 4))
        grid.set(move: .game(9), pos: Position(x: 5, y: 5))

        var nums = grid.numbersFor(nth: 3, set: .column)
        XCTAssert(Set([1, 2, 3]).elementsEqual(nums))

        nums = grid.numbersFor(nth: 4, set: .column)
        XCTAssert(Set([4, 5, 6]).elementsEqual(nums))

        nums = grid.numbersFor(nth: 5, set: .column)
        XCTAssert(Set([7, 8, 9]).elementsEqual(nums))
    }

    func testNumbersForGrid() {
        var grid = SudokuGrid()
        grid.set(move: .game(1), pos: Position(x: 3, y: 3))
        grid.set(move: .game(2), pos: Position(x: 3, y: 4))
        grid.set(move: .game(3), pos: Position(x: 3, y: 5))
        grid.set(move: .game(4), pos: Position(x: 4, y: 3))
        grid.set(move: .game(5), pos: Position(x: 4, y: 4))
        grid.set(move: .game(6), pos: Position(x: 4, y: 5))
        grid.set(move: .game(7), pos: Position(x: 5, y: 3))
        grid.set(move: .game(8), pos: Position(x: 5, y: 4))
        grid.set(move: .game(9), pos: Position(x: 5, y: 5))
        XCTAssert(Set([]).elementsEqual(grid.numbersFor(nth: 3, set: .grid)))

        XCTAssert(Set([1, 2, 3, 4, 5, 6, 7, 8, 9]).elementsEqual(grid.numbersFor(nth: 4, set: .grid)))

        XCTAssert(Set([]).elementsEqual(grid.numbersFor(nth: 5, set: .grid)))
    }


    // MARK: - Grid
    func testGridForPosition() {
        let grid = SudokuGrid()

        XCTAssertEqual(grid.grid(for: Position(x: 0, y: 0)), 0)
        XCTAssertEqual(grid.grid(for: Position(x: 4, y: 1)), 1)
        XCTAssertEqual(grid.grid(for: Position(x: 8, y: 8)), 8)
        XCTAssertEqual(grid.grid(for: Position(x: 4, y: 4)), 4)
        XCTAssertEqual(grid.grid(for: Position(x: 3, y: 3)), 4)
        XCTAssertEqual(grid.grid(for: Position(x: 5, y: 5)), 4)
    }

    // MARK: - isSmart
    func testIsSmartRow() {
        var grid = SudokuGrid()
        grid.set(move: .game(1), pos: Position(x: 5, y: 6))
        grid.set(move: .game(2), pos: Position(x: 6, y: 6))
        grid.set(move: .game(3), pos: Position(x: 7, y: 6))


        XCTAssertFalse(grid.isSmart(move: .player(1), forNth: 6, set: .row))
        XCTAssertFalse(grid.isSmart(move: .player(2), forNth: 6, set: .row))
        XCTAssertFalse(grid.isSmart(move: .player(3), forNth: 6, set: .row))

        XCTAssert(grid.isSmart(move: .player(4), forNth: 6, set: .row))
        XCTAssert(grid.isSmart(move: .player(5), forNth: 6, set: .row))
        XCTAssert(grid.isSmart(move: .player(6), forNth: 6, set: .row))
    }

    // MARK: - isSmart
    func testIsSmartolumn() {
        var grid = SudokuGrid()
        grid.set(move: .game(1), pos: Position(x: 5, y: 6))
        grid.set(move: .game(2), pos: Position(x: 6, y: 6))
        grid.set(move: .game(3), pos: Position(x: 7, y: 6))


        XCTAssertFalse(grid.isSmart(move: .player(1), forNth: 5, set: .column))
        XCTAssertFalse(grid.isSmart(move: .player(2), forNth: 6, set: .column))
        XCTAssertFalse(grid.isSmart(move: .player(3), forNth: 7, set: .column))

        XCTAssert(grid.isSmart(move: .player(4), forNth: 5, set: .column))
        XCTAssert(grid.isSmart(move: .player(5), forNth: 6, set: .column))
        XCTAssert(grid.isSmart(move: .player(6), forNth: 7, set: .column))
    }

    func testIsSmartGrid() {
        var grid = SudokuGrid()
        grid.set(move: .game(1), pos: Position(x: 3, y: 3))
        grid.set(move: .game(2), pos: Position(x: 3, y: 4))
        grid.set(move: .game(3), pos: Position(x: 3, y: 5))
        grid.set(move: .game(4), pos: Position(x: 4, y: 3))
        grid.set(move: .game(5), pos: Position(x: 4, y: 4))
        grid.set(move: .game(6), pos: Position(x: 4, y: 5))


        XCTAssertFalse(grid.isSmart(move: .player(1), forNth: 4, set: .grid))
        XCTAssertFalse(grid.isSmart(move: .player(2), forNth: 4, set: .grid))
        XCTAssertFalse(grid.isSmart(move: .player(3), forNth: 4, set: .grid))

        XCTAssert(grid.isSmart(move: .player(7), forNth: 4, set: .grid))
        XCTAssert(grid.isSmart(move: .player(8), forNth: 4, set: .grid))
        XCTAssert(grid.isSmart(move: .player(9), forNth: 4, set: .grid))

        XCTAssert(grid.isSmart(move: .player(1), forNth: 1, set: .grid))
        XCTAssert(grid.isSmart(move: .player(2), forNth: 2, set: .grid))
        XCTAssert(grid.isSmart(move: .player(3), forNth: 3, set: .grid))
    }


    // MARK: - isLegal
    func testIsValidAny() {
        var grid = SudokuGrid()
        grid.set(move: .game(1), pos: Position(x: 3, y: 3))
        grid.set(move: .game(2), pos: Position(x: 3, y: 4))
        grid.set(move: .game(3), pos: Position(x: 3, y: 5))
        grid.set(move: .game(4), pos: Position(x: 4, y: 3))
        grid.set(move: .game(5), pos: Position(x: 4, y: 4))
        grid.set(move: .game(6), pos: Position(x: 4, y: 5))


        XCTAssertFalse(grid.isSmart(move: .player(1), forNth: 4, set: .grid))
        XCTAssertFalse(grid.isSmart(move: .player(2), forNth: 4, set: .grid))
        XCTAssertFalse(grid.isSmart(move: .player(3), forNth: 4, set: .grid))
    }

    func testIsSmartExistingNumber() {
        var grid = SudokuGrid()
        grid.set(move: .game(1), pos: Position(x: 0, y: 0))

        XCTAssertFalse(grid.isLegal(move: .game(1), at: Position(x: 0, y: 0)))
        XCTAssertFalse(grid.isLegal(move: .game(2), at: Position(x: 0, y: 0)))
        XCTAssertFalse(grid.isLegal(move: .game(9), at: Position(x: 0, y: 0)))
    }
}
