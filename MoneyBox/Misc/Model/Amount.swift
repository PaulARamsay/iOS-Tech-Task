//
//  Amount.swift
//  MoneyBox
//
//  Created by Paul Ramsay on 09/03/2024.
//

import Foundation

struct Amount {
    
    var underlyingValue: Double
    
    init(_ underlyingValue: Double?) {
        self.underlyingValue = underlyingValue ?? 0
    }
    
    func formattedAmount() -> String {
        let doubleString = String(format: "%.2f", self.underlyingValue)
        return "£\(doubleString)"
    }
}
