//
//  SudokuGridView.swift
//  sudoku
//
//  Created by Johnny Sparks  on 12/9/18.
//  Copyright © 2018 Johnny Sparks . All rights reserved.
//

import Foundation
import UIKit

class SudokuGridView: UICollectionView {

    var sudokuGrid: SudokuGrid = SudokuGrid() {
        didSet {
            reloadData()
        }
    }

    var onTap: ((Position) -> Void)?

    init() {
        let layout = UICollectionViewFlowLayout()
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: layout)
        delegate = self
        dataSource = self

        register(SudokuGridCell.self, forCellWithReuseIdentifier: "SudokuGridCell")
    }

    override func layoutSubviews() {
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }

        let cells = sudokuGrid.size
        let width = min(bounds.size.height, bounds.size.width)

        layout.itemSize = CGSize(width: width / CGFloat(cells) - 1,
                                 height: width / CGFloat(cells) - 1)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1

        super.layoutSubviews()
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

extension SudokuGridView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onTap?(indexPath.toPosition())
    }
}


extension SudokuGridView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sudokuGrid.size
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sudokuGrid.size
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: "SudokuGridCell", for: indexPath) as! SudokuGridCell
        let pos = indexPath.toPosition()
        let move = sudokuGrid.move(at: pos)

        if let val = move.val {
            cell.label.text = "\(val)"
        } else {
            cell.label.text = ""
        }

        switch move.player {
        case .game:
            cell.label.textColor = .gray
        case .user:
            var other = sudokuGrid
            other.set(move: .none, pos: pos)
            cell.label.textColor = other.isSmart(move: move, at: pos) ? .black : .red
        default: break
        }

        return cell
    }
}
