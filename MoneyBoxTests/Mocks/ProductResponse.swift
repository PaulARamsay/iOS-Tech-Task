//
//  ProductResponse.swift
//  MoneyBoxTests
//
//  Created by Paul Ramsay on 09/03/2024.
//

import Foundation
import Networking

@testable import MoneyBox
extension ProductResponse {

    static func mock() -> ProductResponse {
        return .init(id: nil,
                     assetBoxGlobalID: nil,
                     planValue: 300,
                     moneybox: 150,
                     subscriptionAmount: nil,
                     totalFees: 400,
                     isSelected: nil,
                     isFavourite: nil,
                     collectionDayMessage: nil,
                     wrapperID: nil,
                     isCashBox: nil,
                     pendingInstantBankTransferAmount: nil,
                     assetBox: nil,
                     product: .mock(name: "ISA"),
                     investorAccount: nil,
                     personalisation: nil,
                     contributions: nil,
                     moneyboxCircle: nil,
                     isSwitchVisible: nil,
                     state: nil,
                     dateCreated: nil)
    }
}
