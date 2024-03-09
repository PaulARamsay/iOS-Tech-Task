//
//  AmountSelectorTableViewCell.swift
//  MoneyBox
//
//  Created by Paul Ramsay on 09/03/2024.
//

import UIKit

// MARK: - Delegate

protocol AmountSelectorTableViewCellDelegate: AnyObject {
    func amountSelectorTableViewCellDidChange(amount: Double,
                                              in cell: AmountSelectorTableViewCell)
}

// MARK: - TableViewCell

class AmountSelectorTableViewCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var amountStepper: UIStepper!
    
    weak var delegate: AmountSelectorTableViewCellDelegate?
    
    // MARK: - Configure
    
    func configure(startAmount: Double,
                   delegate: AmountSelectorTableViewCellDelegate) {
        self.delegate = delegate
        self.updateAmountLabel(amount: startAmount)
        self.amountStepper.value = startAmount
    }
    
    @IBAction private func amountValueDidChange(_ sender: UIStepper) {
        self.updateAmountLabel(amount: sender.value)
    }
    
    private func updateAmountLabel(amount: Double) {
        self.amountLabel.text = amount.asAmount().formattedAmount()
    }
}

// MARK: - NibLoadableCell

extension AmountSelectorTableViewCell: NibLoadableCell {}
