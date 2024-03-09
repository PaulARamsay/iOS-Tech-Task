//
//  LoginFetchingAccountDetailsPresenterTests.swift
//  MoneyBoxTests
//
//  Created by Paul Ramsay on 09/03/2024.
//

import XCTest
import Networking

@testable import MoneyBox

class LoginFetchingAccountDetailsPresenterTests: XCTestCase {

    private var presenter: LoginFetchingAccountDetailsPresenter!
    private var view: MockView!
    private var apiSession: MockAPISession!
    private var delegate: Delegate!
    private var dataProvider: MockDataProvider!
    
    override func setUpWithError() throws {
        self.view = MockView()
        self.apiSession = MockAPISession()
        self.delegate = Delegate()
        self.dataProvider = MockDataProvider()
        
        self.presenter = .init(view: self.view,
                               apiSession: self.apiSession,
                               delegate: self.delegate,
                               dataProvider: self.dataProvider)
    }
    
    func testDidGetAccountDetailsAndNavigateToAccounts() {
        self.dataProvider.fetchProductsResponse = .success(.mock())
        self.presenter.viewDidLoad()
        XCTAssertTrue(self.delegate.didNavigateToAccountDetails)
    }
    
    func testDidNavigateBackToLogin() {
        self.presenter.didTapCancel()
        XCTAssertTrue(self.delegate.didNavigateBackToLogin)
    }
    
    func testDidRetryWithFailedNetworkCall() {
        self.dataProvider.fetchProductsResponse = .failure(NSError.error(with: "Teapot"))
        self.presenter.viewDidLoad()
        
        XCTAssertFalse(self.delegate.didNavigateBackToLogin)

        self.dataProvider.fetchProductsResponse = .success(.mock())
        
        self.presenter.didTapRetry()

        XCTAssertTrue(self.delegate.didNavigateToAccountDetails)
    }
    
    func testAlertCopy() {
        self.dataProvider.fetchProductsResponse = .failure(NSError.error(with: "Teapot"))
        self.presenter.viewDidLoad()
        
        XCTAssertEqual(self.view.alertTitle, "Oops, something went wrong")
        XCTAssertEqual(self.view.alertBody, "Error: Teapot")
        XCTAssertEqual(self.view.retryButtonText, "Retry")
        XCTAssertEqual(self.view.cancelButtonText, "Cancel")
    }
}

// MARK: - MockDelegate

private class Delegate: LoginFetchingAccountDetailsDelegate {
    
    var didNavigateBackToLogin = false
    var didNavigateToAccountDetails = false
    
    func LoginFetchingAccountDetailsPresenterDidFailLogin(in presenter: LoginFetchingAccountDetailsPresenter) {
        self.didNavigateBackToLogin = true
    }
    
    func LoginFetchingAccountDetailsPresenterDidLoginSuccessully(withAccountDetails accountDetails: AccountResponse,
                                                                 apiSession: APISessionable,
                                                                 in presenter: LoginFetchingAccountDetailsPresenter) {
        self.didNavigateToAccountDetails = true
    }
}

// MARK: - MockClass

private class MockView: LoginFetchinAccountDetailsView {
    
    var alertTitle: String?
    var alertBody: String?
    var retryButtonText: String?
    var cancelButtonText: String?
    
    func showAlert(withTitle title: String?, body: String, retryButtonText: String, cancelButtonText: String) {
        self.alertTitle = title
        self.alertBody = body
        self.retryButtonText = retryButtonText
        self.cancelButtonText = cancelButtonText
    }
}
