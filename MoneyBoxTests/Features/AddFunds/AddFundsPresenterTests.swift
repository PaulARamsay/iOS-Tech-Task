//
//  AddFundsPresenterTests.swift
//  MoneyBoxTests
//
//  Created by Paul Ramsay on 09/03/2024.
//

import XCTest
import Networking

@testable import MoneyBox
class AddFundsPresenterTests: XCTestCase {

    private var presenter: AddFundsPresenter!
    private var delegate: MockDelegate!
    private var view: MockView!
    private var apiSession: APISessionable!
    private var accountResponse: AccountResponse!
    private var dataProvider: MockDataProvider!

    override func setUpWithError() throws {
        self.view = .init()
        self.delegate = .init()
        self.apiSession = MockAPISession()
        self.accountResponse = .mock()
        self.dataProvider = .init()
        self.presenter = .init(view: self.view,
                               delegate: self.delegate,
                               productResponse: .mock(),
                               apiSession: self.apiSession,
                               dataProvider: self.dataProvider)
        self.presenter.viewDidLoad()
    }

    func testDidAddSuccessfully() {
        self.dataProvider.addMoneyResponse = .success(.mock())
        self.presenter.didTapPrimaryButton()
        XCTAssertTrue(self.view.didShowAlert)
    }
    
    func testDidChangeStepperValue() {
        self.dataProvider.addMoneyResponse = .success(.mock())
        self.presenter.selectedAmountDidChange(amount: 25)
        self.presenter.didTapPrimaryButton()
        XCTAssertTrue(self.view.didShowAlert)
        XCTAssertEqual(self.dataProvider.moneyboxValue, 25)
    }
    
    func testDidShowRetryAlert() {
        self.dataProvider.addMoneyResponse = .failure(NSError.error(with: ""))
        self.presenter.didTapPrimaryButton()
        XCTAssertTrue(self.view.didShowRetryAlert)
    }
    
    func testDidSetNavTitle() {
        XCTAssertEqual(self.view.navTitle, "Add Funds")
    }
    
    func testDidUpdateButtonTitle() {
        XCTAssertEqual(self.view.buttonTitle, "Add Funds")
    }
    
    func testDidTapRetryButton() {
        self.dataProvider.addMoneyResponse = .failure(NSError.error(with: ""))
        self.presenter.didTapPrimaryButton()
        XCTAssertTrue(self.view.didShowRetryAlert)
        
        self.dataProvider.addMoneyResponse = .success(.mock())
        self.presenter.didTapPrimaryButton()
        XCTAssertTrue(self.view.didShowAlert)
    }
    
    func testDidTapCloseButton() {
        self.presenter.didTapClose()
        XCTAssertTrue(self.delegate.didCloseModalView)
    }
}

// MARK: - MockDelegate

private class MockDelegate: AddFundsPresenterDelegate {
    
    var didCloseModalView = false
    
    func addFundsPresenterDidWillClose(in presenter: AddFundsPresenter) {
        self.didCloseModalView = true
    }
}

// MARK: - MockView

private class MockView: AddFundsView {
    
    var buttonTitle: String?
    var navTitle: String?
    var didShowRetryAlert = false
    var didShowAlert = false
    
    func update(buttonText: String) {
        self.buttonTitle = buttonText
    }
    
    func update(navigationTitle: String) {
        self.navTitle = navigationTitle
    }
    
    func showAlert(withTitle title: String?, body: String, retryButtonText: String, cancelButtonText: String) {
        self.didShowRetryAlert = true
    }
    
    func showAlert(withTitle title: String?, body: String, ctaTitle: String) {
        self.didShowAlert = true
    }
    
    func updatingLoadingState(loading: Bool) {}
}
