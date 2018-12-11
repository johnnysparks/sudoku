//
//  SudokuGridCell.swift
//  sudoku
//
//  Created by Johnny Sparks  on 12/9/18.
//  Copyright © 2018 Johnny Sparks . All rights reserved.
//

import Foundation
import UIKit

class SudokuGridCell: UICollectionViewCell {
    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .black
        label.layer.borderColor = UIColor.blue.cgColor
        label.layer.borderWidth = 1
        label.textAlignment = .center

        contentView.backgroundColor = .white

        contentView.addSubview(label)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = bounds
        label.frame = bounds
    }
}
