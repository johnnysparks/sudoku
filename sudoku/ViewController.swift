//
//  ViewController.swift
//  sudoku-vision
//
//  Created by Johnny Sparks  on 12/8/18.
//  Copyright © 2018 Johnny Sparks . All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var sudokuGrid = SudokuGrid()
    let sudokuGridView = SudokuGridView()
    let pickerView = SudokuNumberPicker()

    func update() {
        pickerView.sudokuGrid = self.sudokuGrid
        sudokuGridView.sudokuGrid = self.sudokuGrid
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        sudokuGridView.onTap = { [weak self] pos in
            self?.pickerView.selectedNumber = self?.sudokuGrid.number(at: pos)
            self?.pickerView.onPick = { val in
                guard let self = self else { return }
                let move = Move(player: .user, val: val)
                if self.sudokuGrid.isLegal(move: move, at: pos) {
                    self.sudokuGrid.set(move: move, pos: pos)
                }
                self.update()
            }
        }

        view.addSubview(sudokuGridView)
        view.addSubview(pickerView)
        view.backgroundColor = .white
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sudokuGrid = SudokuGame.generateGame(difficulty: .easy)
        update()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let size = min(view.bounds.width, view.bounds.height - 20)
        sudokuGridView.frame = CGRect(x: 0, y: 20, width: size, height: size)

        pickerView.frame = CGRect(x: 0, y: sudokuGridView.frame.maxY, width: view.bounds.width, height: view.bounds.height - sudokuGridView.frame.maxY)
    }
}


