//
//  SudokuNumberPicker.swift
//  sudoku
//
//  Created by Johnny Sparks  on 12/10/18.
//  Copyright © 2018 Johnny Sparks . All rights reserved.
//

import Foundation
import UIKit

class SudokuNumberPicker: UIPickerView {

    var onPick: ((Int?) -> Void)?

    var sudokuGrid: SudokuGrid? {
        didSet {
            reloadAllComponents()
        }
    }

    var selectedNumber: Int? {
        didSet {
            guard let selectedNumber = selectedNumber, selectedNumber > 0, selectedNumber <= sudokuGrid?.size ?? 0 else {
                selectRow(0, inComponent: 0, animated: true)
                return
            }

            selectRow(selectedNumber, inComponent: 0, animated: true)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        delegate = self
        dataSource = self
        sudokuGrid = nil
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SudokuNumberPicker: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        guard row > 0 else {
            onPick?(nil)
            return
        }

        onPick?(row)
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return row == 0 ? "-" : "\(row)"
    }
}

extension SudokuNumberPicker: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let size = sudokuGrid?.size else {
            return 0
        }
        return size + 1
    }
}
