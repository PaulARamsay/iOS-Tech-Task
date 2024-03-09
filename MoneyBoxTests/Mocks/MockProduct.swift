//
//  MockProduct.swift
//  MoneyBoxTests
//
//  Created by Paul Ramsay on 09/03/2024.
//

import Foundation
import Networking

@testable import MoneyBox
extension Product {
    
    static func mock(name: String = "ISA") -> Product {
        return .init(id: nil,
                     name: name,
                     categoryType: nil,
                     type: nil,
                     friendlyName: "Test ISA",
                     canWithdraw: nil,
                     productHexCode: nil,
                     annualLimit: nil,
                     depositLimit: nil,
                     bonusMultiplier: nil,
                     minimumWeeklyDeposit: nil,
                     maximumWeeklyDeposit: nil,
                     documents: nil,
                     state: nil,
                     wrapperDefinitionGlobalID: nil,
                     lisa: nil,
                     interestRate: nil,
                     interestRateAmount: nil,
                     logoURL: nil,
                     fund: .mock())
    }
}
