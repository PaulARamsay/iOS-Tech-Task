//
//  MockLoginResponse.swift
//  MoneyBoxTests
//
//  Created by Paul Ramsay on 09/03/2024.
//

import Foundation
import Networking

@testable import MoneyBox
extension LoginResponse {
    
    static func mock(token: String = "12345", firstName: String = "Davy", lastName: String = "Jones") -> LoginResponse {
        return LoginResponse(session: .init(bearerToken: token),
                             user: .init(firstName: firstName, lastName: lastName))
    }
}
