//
//  MockFund.swift
//  MoneyBoxTests
//
//  Created by Paul Ramsay on 09/03/2024.
//

import Foundation
import Networking

extension Fund {
    
    static func mock() -> Fund {
        return .init(fundId: 1, name: "Test", logoURL: nil, isFundDMB: nil)
    }
}
