//
//  NetworkError.swift
//  MoneyBox
//
//  Created by Paul Ramsay on 09/03/2024.
//

import Foundation
import Networking

protocol APISessionable {
    var session: LoginResponse.Session? { get set }
    var user: LoginResponse.User? { get set }

    func setUserToken(_ token: String)
    func removeUserToken()
}

struct APISession: APISessionable {
    
    private let sessionManager = SessionManager()
    var session: LoginResponse.Session?
    var user: LoginResponse.User?
    
    func setUserToken(_ token: String) {
        self.sessionManager.setUserToken(token)
    }
    
    func removeUserToken() {
        self.sessionManager.removeUserToken()
    }
}
