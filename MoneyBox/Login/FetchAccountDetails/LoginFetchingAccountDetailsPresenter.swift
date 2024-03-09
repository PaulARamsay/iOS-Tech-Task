//
//  LoginFetchingAccountDetailsPresenter.swift
//  MoneyBox
//
//  Created by Paul Ramsay on 09/03/2024.
//

import Foundation
import Networking

// MARK: - Presenting Protocol

protocol LoginFetchingAccountDetailsPresenting: AnyObject {
    func viewDidLoad()
    func didTapRetry()
    func didTapCancel()
}

// MARK: - Delegate

protocol LoginFetchingAccountDetailsDelegate: AnyObject {
    func LoginFetchingAccountDetailsPresenterDidLoginSuccessully(withAccountDetails accountDetails: AccountResponse,
                                                                 apiSession: APISessionable,
                                                                 in presenter: LoginFetchingAccountDetailsPresenter)
    func LoginFetchingAccountDetailsPresenterDidFailLogin(in presenter: LoginFetchingAccountDetailsPresenter)
}

// MARK: - Presenter

class LoginFetchingAccountDetailsPresenter {
    
    // MARK: - Properties (Public)
    
    weak var view: LoginFetchinAccountDetailsView!
    weak var delegate: LoginFetchingAccountDetailsDelegate?
    
    //MARK: - Properties (Private)
    
    let apiSession: APISessionable
    let dataProvider: DataProviderLogic
    
    // MARK: - Initialiser
    
    init(view: LoginFetchinAccountDetailsView,
         apiSession: APISessionable,
         delegate: LoginFetchingAccountDetailsDelegate,
         dataProvider: DataProviderLogic = DataProvider()) {
        self.view = view
        self.apiSession = apiSession
        self.delegate = delegate
        self.dataProvider = dataProvider
    }
    
    // MARK: - Helpers
    
    private func getAccountDetails() {
        self.dataProvider.fetchProducts { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):

                self.delegate?.LoginFetchingAccountDetailsPresenterDidLoginSuccessully(withAccountDetails: response,
                                                                                       apiSession: self.apiSession,
                                                                                       in: self)
                
            case .failure(let error):
                self.view.showAlert(withTitle: Strings.FetchinAccountDetails.alertTitle,
                                    body: Strings.FetchinAccountDetails.alertBody.localized(withValue: error.localizedDescription),
                                    retryButtonText: Strings.FetchinAccountDetails.retryTitle,
                                    cancelButtonText: Strings.FetchinAccountDetails.cancelTitle)
            }
        }
    }
}

// MARK: - LoginFetchingAccountDetailsPresenting

extension LoginFetchingAccountDetailsPresenter: LoginFetchingAccountDetailsPresenting {
    
    func viewDidLoad() {
        self.getAccountDetails()
    }
    
    func didTapRetry() {
        self.getAccountDetails()
    }
    
    func didTapCancel() {
        self.delegate?.LoginFetchingAccountDetailsPresenterDidFailLogin(in: self)
    }
}

