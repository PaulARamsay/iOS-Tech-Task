//
//  AccountPresenterTests.swift
//  MoneyBoxTests
//
//  Created by Paul Ramsay on 09/03/2024.
//

import XCTest
import Networking

@testable import MoneyBox
class AccountPresenterTests: XCTestCase {
    
    private var presenter: AccountPresenter!
    private var delegate: MockDelegate!
    private var view: MockView!
    private var apiSession: APISessionable!
    private var accountResponse: AccountResponse!

    override func setUpWithError() throws {
        self.view = .init()
        self.delegate = .init()
        self.apiSession = MockAPISession()
        self.accountResponse = .mock()
        self.presenter = .init(view: self.view,
                               accountDetails: self.accountResponse,
                               delegate: self.delegate,
                               apiSession: self.apiSession)
        self.presenter.viewDidLoad()
    }
    
    func testNumberOfSections() {
        XCTAssertEqual(self.presenter.sections.count, 4)
    }
    
    func testNumberOfRowsPerSection() {
        XCTAssertEqual(self.presenter.sections[0].rows.count, 2)
        XCTAssertEqual(self.presenter.sections[1].rows.count, 1)
        XCTAssertEqual(self.presenter.sections[2].rows.count, 1)
        XCTAssertEqual(self.presenter.sections[3].rows.count, 1)
    }
    
    func testDidTapAccount() {
        self.presenter.didTapItemAt(indexPath: IndexPath(row: 0, section: 1))
        XCTAssertNotNil(self.delegate.product)
    }
    
    func testProductCellCopy() {
        let product = self.presenter.sections[2].rows.first
        switch product {
        case .product(let accountTitle,
                      let accountPlan,
                      let moneyBoxValue,
                      _):
            
            XCTAssertEqual(accountTitle, "Plan: ISA")
            XCTAssertEqual(accountPlan, "Plan Value: £300.00")
            XCTAssertEqual(moneyBoxValue, "Moneybox: £150.00")
        
        default:
            XCTFail()
        }
    }
    
    func testHeaderSection() {
        XCTAssertEqual(self.titleForRow(indexPath: .init(row: 0, section: 0)), "Hello Ted")
        XCTAssertEqual(self.titleForRow(indexPath: .init(row: 1, section: 0)), "Total plan value: £0.00")
    }
    
    private func titleForRow(indexPath: IndexPath) -> String {
        let row = self.presenter.sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .title(let title):
            return title
            
        default:
            XCTFail()
            return ""
        }
    }
}

// MARK: - MockView

private class MockView: AccountView {
    
    var title: String?
    
    func update(title: String) {
        self.title = title
    }
}

// MARK: - MockDelegate

private class MockDelegate: AccountPresenterDelegate {
    
    var product: ProductResponse?
    
    func accountPresenterDidTap(product: ProductResponse, in presenter: AccountPresenter) {
        self.product = product
    }
}
