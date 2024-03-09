//
//  MockAPISessionable.swift
//  MoneyBoxTests
//
//  Created by Paul Ramsay on 09/03/2024.
//

import Foundation
import Networking

@testable import MoneyBox
class MockAPISession: APISessionable {
    
    var session: LoginResponse.Session?
    var user: LoginResponse.User? = .init(firstName: "Ted", lastName: "Lasso")
    
    var token: String?
    
    func setUserToken(_ token: String) {
        self.token = token
    }
    
    func removeUserToken() {
        self.token = nil
    }
}
