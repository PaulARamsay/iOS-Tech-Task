//
//  MockAccount.swift
//  MoneyBoxTests
//
//  Created by Paul Ramsay on 09/03/2024.
//

import Foundation
import Networking

@testable import MoneyBox
extension Account {
    
    static func mock() -> Account {
        return .init(type: nil,
                     name: "James May",
                     deepLinkIdentifier: nil,
                     wrapper: nil,
                     milestone: nil,
                     hasCollections: nil)
    }
}
