//
//  Strings+Extensions.swift
//  MoneyBox
//
//  Created by Paul Ramsay on 09/03/2024.
//

import Foundation

extension String {
    
    func localized(withValue value: String) -> String {
        return self.replacingOccurrences(of: "%@", with: value)
    }
}
