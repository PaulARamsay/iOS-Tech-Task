//
//  MockAccountResponse.swift
//  MoneyBoxTests
//
//  Created by Paul Ramsay on 09/03/2024.
//

import Foundation
import Networking

@testable import MoneyBox
extension AccountResponse {
    
    static func mock(products: [ProductResponse] = [.mock(), .mock(), .mock()]) -> AccountResponse {
        // I would never do this and ideally i'd build a mock AccountResponse to return
        // So we could test specific scenarios
        return .init(moneyboxEndOfTaxYear: "",
                     totalPlanValue: 0,
                     totalEarnings: 0,
                     totalContributionsNet: 0,
                     totalEarningsAsPercentage: 0,
                     productResponses: [.mock(), .mock(), .mock()],
                     accounts: [.mock()])
    }
}
