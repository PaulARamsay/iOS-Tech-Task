//
//  ProductTableViewCell.swift
//  MoneyBox
//
//  Created by Paul Ramsay on 09/03/2024.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var bodyLabel: UILabel!
    @IBOutlet private weak var supplementaryLabel: UILabel!

    func configure(title: String,
                   body: String,
                   supplementaryLabel: String) {
        self.titleLabel.text = title
        self.bodyLabel.text = body
        self.supplementaryLabel.text = supplementaryLabel
    }
}

// MARK: - NibLoadableCell

extension ProductTableViewCell: NibLoadableCell {}
