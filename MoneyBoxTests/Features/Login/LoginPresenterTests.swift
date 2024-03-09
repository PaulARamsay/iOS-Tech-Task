//
//  LoginPresenterTests.swift
//  MoneyBoxTests
//
//  Created by Paul Ramsay on 09/03/2024.
//

import XCTest

@testable import MoneyBox
class LoginPresenterTests: XCTestCase {

    private var mockView: MockView!
    private var presenter: LoginPresenter!
    private var mockProvider: MockDataProvider!
    private var apiSession: MockAPISession!
    private var delegate: MockDelegate!
    
    override func setUpWithError() throws {
        self.mockView = MockView()
        self.mockProvider = MockDataProvider()
        self.apiSession = MockAPISession()
        self.delegate = MockDelegate()
        
        self.presenter = .init(view: self.mockView,
                               delegate: self.delegate,
                               dataProvider: self.mockProvider,
                               apiSession: self.apiSession)
    }
    
    func testDidConfigureView() {
        self.presenter.viewDidLoad()
        XCTAssertEqual(self.mockView.secondaryButtonTitle, "Forgotten Password")
        XCTAssertEqual(self.mockView.primaryActionButtonTitle, "Login")
        XCTAssertEqual(self.mockView.emailFieldTitle, "Email")
        XCTAssertEqual(self.mockView.passswordFieldTitle, "Password")
    }
    
    func testButtonStateUpdatedWithTextInput() {
        self.presenter.didUpdatePasswordField(withString: "12345")
        XCTAssertFalse(self.mockView.buttonEnabled)
        self.presenter.didUpdateUsernameField(withString: "12345")
        XCTAssertTrue(self.mockView.buttonEnabled)
    }
    
    func testButtonStateWasDisabledWithDeletedPassword() {
        self.presenter.didUpdatePasswordField(withString: "12345")
        self.presenter.didUpdateUsernameField(withString: "12345")
        XCTAssertTrue(self.mockView.buttonEnabled)
        
        self.presenter.didUpdateUsernameField(withString: "")
        XCTAssertFalse(self.mockView.buttonEnabled)
    }
    
    func testTokenWasSetInApiSession() {
        self.presenter.didUpdateUsernameField(withString: "1234")
        self.presenter.didUpdatePasswordField(withString: "1234")
        self.mockProvider.loginResultResponse = .success(.mock(token: "12345"))
        self.presenter.didTapPrimaryButton()
        XCTAssertEqual(self.apiSession.token, "12345")
        XCTAssertEqual(self.apiSession.user?.firstName, "Davy")
        XCTAssertEqual(self.apiSession.user?.lastName, "Jones")
        
        XCTAssertTrue(self.delegate.didLoginSuccessfully)
    }
    
    func testDidShowAlertForForgottenPassword() {
        self.presenter.didTapForgottenPassword()
        
        XCTAssertEqual(self.mockView.alertTitle, "Not Implemented")
        XCTAssertEqual(self.mockView.alertBody, "Try again later")
        XCTAssertEqual(self.mockView.ctaTitle, "Okay")
    }
    
    func testDidShowAlertForFailedNetworkRequest() {
        self.presenter.didUpdateUsernameField(withString: "1234")
        self.presenter.didUpdatePasswordField(withString: "1234")
        self.mockProvider.loginResultResponse = .failure(NSError.error(with: "These are not the droids you are looking for"))

        self.presenter.didTapPrimaryButton()
        XCTAssertNil(self.mockView.alertTitle)
        XCTAssertEqual(self.mockView.alertBody, "Error: These are not the droids you are looking for")
        XCTAssertEqual(self.mockView.ctaTitle, "Dismiss")
    }
    
    func testDidNavigateToAccountOverview() {
        self.presenter.didUpdateUsernameField(withString: "1234")
        self.presenter.didUpdatePasswordField(withString: "1234")
        self.mockProvider.loginResultResponse = .success(.mock())
        self.presenter.didTapPrimaryButton()
        XCTAssertTrue(self.delegate.didLoginSuccessfully)
    }
}

private class MockDelegate: LoginPresenterDelegate {
    
    var didLoginSuccessfully = false
    
    func loginPresenterdidLoginSuccessfully(forApiSession apiSession: APISessionable) {
        self.didLoginSuccessfully = true
    }
}

// MARK: - Mock Login View

private class MockView: LoginView {
    
    var alertTitle: String?
    var alertBody: String?
    var ctaTitle: String?

    var buttonEnabled = false

    var didUpdateButtonState = false
    var didUpdateLoadingState = false
    
    var annoucement: String?
    var emailFieldTitle: String?
    var passswordFieldTitle: String?
    var primaryActionButtonTitle: String?
    var secondaryButtonTitle: String?
    
    func showAlert(withTitle title: String?, body: String, ctaTitle: String) {
        self.alertTitle = title
        self.alertBody = body
        self.ctaTitle = ctaTitle
    }
    
    func updateButtonState(isEnabled enabled: Bool) {
        self.buttonEnabled = enabled
    }
    
    func update(emailTextfieldTitle: String, passwordTextfieldTitle: String, primaryActionButtonText: String, secondaryActionButtonText: String) {
        self.emailFieldTitle = emailTextfieldTitle
        self.passswordFieldTitle = passwordTextfieldTitle
        self.primaryActionButtonTitle = primaryActionButtonText
        self.secondaryButtonTitle = secondaryActionButtonText
    }
    
    func updatingLoadingState(loading: Bool) {
        self.didUpdateLoadingState = true
    }
    
    func announce(message: String) {
        self.annoucement = message
    }
    
    
}
