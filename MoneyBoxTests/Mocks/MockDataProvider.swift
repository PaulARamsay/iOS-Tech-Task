//
//  MockDataProvider.swift
//  MoneyBoxTests
//
//  Created by Paul Ramsay on 09/03/2024.
//

import Foundation
import Networking

class MockDataProvider: DataProviderLogic {
    
    var loginResultResponse: Result<LoginResponse, Error>!
    var fetchProductsResponse: Result<AccountResponse, Error>!
    var addMoneyResponse: Result<OneOffPaymentResponse, Error>!
    
    var moneyboxValue: Int?
    
    public func login(request: LoginRequest, completion: @escaping ((Result<LoginResponse, Error>) -> Void)) {
        completion(self.loginResultResponse)
    }
    
    public func fetchProducts(completion: @escaping ((Result<AccountResponse, Error>) -> Void)) {
        completion(self.fetchProductsResponse)
    }
    
    public func addMoney(request: OneOffPaymentRequest, completion: @escaping ((Result<OneOffPaymentResponse, Error>) -> Void)) {
        self.moneyboxValue = request.amount
        completion(self.addMoneyResponse)
    }
}
