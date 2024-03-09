//
//  TitleBodyTableViewCell.swift
//  MoneyBox
//
//  Created by Paul Ramsay on 09/03/2024.
//

import UIKit

class TitleBodyTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var bodyLabel: UILabel!
    
    func configure(title: String, body: String) {
        self.titleLabel.text = title
        self.bodyLabel.text = body
    }
}

// MARK: - NibLoadableCell

extension TitleBodyTableViewCell: NibLoadableCell {}
