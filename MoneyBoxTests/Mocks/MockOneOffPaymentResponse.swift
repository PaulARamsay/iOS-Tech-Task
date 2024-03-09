//
//  MockOneOffPaymentResponse.swift
//  MoneyBoxTests
//
//  Created by Paul Ramsay on 09/03/2024.
//

import Foundation
import Networking

@testable import MoneyBox
extension OneOffPaymentResponse {
    
    static func mock() -> OneOffPaymentResponse {
        return .init(moneybox: 25)
    }
}
