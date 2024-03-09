//
//  LabelTableViewCell.swift
//  MoneyBox
//
//  Created by Paul Ramsay on 09/03/2024.
//

import UIKit

class LabelTableViewCell: UITableViewCell {

    @IBOutlet private weak var label: UILabel!

    func configure(labelText: String) {
        self.label.text = labelText
    }
}

// MARK: - NibLoadableCell

extension LabelTableViewCell: NibLoadableCell {}
