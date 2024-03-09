//
//  LoginPresenter.swift
//  MoneyBox
//
//  Created by Paul Ramsay on 09/03/2024.
//

import Foundation
import Networking

// MARK: - Presenting Protocol

protocol LoginPresenting: AnyObject {
    func viewDidLoad()
    func didTapPrimaryButton()
    func didTapForgottenPassword()
    func didUpdateUsernameField(withString string: String?)
    func didUpdatePasswordField(withString string: String?)
}

// MARK: - Delegate

protocol LoginPresenterDelegate: AnyObject {
    func loginPresenterdidLoginSuccessfully(forApiSession apiSession: APISessionable)
}

// MARK: - Presenter

class LoginPresenter {
    
    // Private Properties
    
    private var email: String = "" {
        didSet {
            self.textfieldWasUpdated()
        }
    }
    
    private var password: String = "" {
        didSet {
            self.textfieldWasUpdated()
        }
    }
    
    private let dataProvider: DataProviderLogic
    private var apiSession: APISessionable
    
    // Public Properties
    
    weak var view: LoginView!
    weak var delegate: LoginPresenterDelegate!
    
    // Lifecycle
    
    init(view: LoginView,
         delegate: LoginPresenterDelegate,
         dataProvider: DataProviderLogic = DataProvider(),
         apiSession: APISessionable = APISession()) {
        self.view = view
        self.dataProvider = dataProvider
        self.apiSession = apiSession
        self.delegate = delegate
    }
    
    // Helpers
    
    private func textfieldWasUpdated() {
        let buttonEnabled = !self.email.isEmpty && !self.password.isEmpty
        self.view.updateButtonState(isEnabled: buttonEnabled)
    }
    
    private func authenticateUser() {
        guard !self.email.isEmpty && !self.password.isEmpty else { return }
        self.view.updatingLoadingState(loading: true)
        self.view.announce(message: Strings.Login.Standard.loadingAnnouncement)
        
        self.dataProvider.login(request: .init(email: email, password: password)) { [weak self] result in
            
            guard let self = self else { return }
            
            self.view.updatingLoadingState(loading: false)

            switch result {
            case .success(let loginResponse):
                self.apiSession.setUserToken(loginResponse.session.bearerToken)
                self.apiSession.user = loginResponse.user
                self.apiSession.session = loginResponse.session
                self.delegate.loginPresenterdidLoginSuccessfully(forApiSession: self.apiSession)
                
            case .failure(let error):
                self.view.showAlert(withTitle: nil,
                                    body: Strings.Generic.Alert.Failure.alertBody.localized(withValue: error.localizedDescription),
                                    ctaTitle: Strings.Generic.Alert.Failure.dismissTitle)
            }
        }
    }
}

// MARK: - LoginPresenting 

extension LoginPresenter: LoginPresenting {
    
    func viewDidLoad() {
        self.view.update(emailTextfieldTitle: Strings.Login.Standard.usernameTextfieldTitle,
                         passwordTextfieldTitle: Strings.Login.Standard.passwordTextfieldTitle,
                         primaryActionButtonText: Strings.Login.Standard.primaryActionButtonTitle,
                         secondaryActionButtonText: Strings.Login.Standard.forgotPasswordTitle)
    }
    
    func didTapPrimaryButton() {
        self.authenticateUser()
    }
    
    func didTapForgottenPassword() {
        self.view.showAlert(withTitle: Strings.Debug.NotImplemented.alertTitle,
                            body: Strings.Debug.NotImplemented.alertBody,
                            ctaTitle: Strings.Debug.NotImplemented.ctaTitle)
    }
    
    func didUpdateUsernameField(withString string: String?) {
        self.email = string ?? ""
    }
    
    func didUpdatePasswordField(withString string: String?) {
        self.password = string ?? ""
    }
}
