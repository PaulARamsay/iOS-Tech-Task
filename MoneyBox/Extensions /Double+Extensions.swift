//
//  Double+Extensions.swift
//  MoneyBox
//
//  Created by Paul Ramsay on 09/03/2024.
//

import Foundation

extension Double {
    
    func asAmount() -> Amount {
        return Amount(self)
    }
}
