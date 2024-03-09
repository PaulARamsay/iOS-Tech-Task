//
//  LoginCoordinator.swift
//  MoneyBox
//
//  Created by Paul Ramsay on 09/03/2024.
//

import Foundation
import UIKit
import Networking

// MARK: - Coordinator Delegate

protocol LoginCoordinatorDelegate: AnyObject {
    func loginCoordinatorDidLoginSuccessfully(withApiSession apiSession: APISessionable,
                                              accountDetails: AccountResponse)
}

// MARK: - Coordinator

class LoginCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    weak var delegate: LoginCoordinatorDelegate?
    
    // MARK: - Initialiser

    init(navigationController: UINavigationController,
         delegate: LoginCoordinatorDelegate) {
        self.navigationController = navigationController
        self.delegate = delegate
    }
    
    // MARK: - Helpers

    func start() {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        let presenter = LoginPresenter(view: view, delegate: self)
        view.presenter = presenter

        self.navigationController.setViewControllers([view], animated: true)
    }
    
    private func fetchAccountDetails(apiSession: APISessionable) {
        let view = LoginFetchingAccountDetailsViewController()
        let presenter = LoginFetchingAccountDetailsPresenter(view: view,
                                                             apiSession: apiSession,
                                                             delegate: self)
        view.presenter = presenter
        self.navigationController.pushViewController(view, animated: true)
    }
}

// MARK: - LoginPresenterDelegate

extension LoginCoordinator: LoginPresenterDelegate {
    
    func loginPresenterdidLoginSuccessfully(forApiSession apiSession: APISessionable) {
        self.fetchAccountDetails(apiSession: apiSession)
    }
}

// MARK: - LoginFetchingAccountDetailsDelegate

extension LoginCoordinator: LoginFetchingAccountDetailsDelegate {
    
    func LoginFetchingAccountDetailsPresenterDidLoginSuccessully(withAccountDetails accountDetails: AccountResponse, apiSession: APISessionable, in presenter: LoginFetchingAccountDetailsPresenter) {
        self.delegate?.loginCoordinatorDidLoginSuccessfully(withApiSession: apiSession, accountDetails: accountDetails)
    }
    
    func LoginFetchingAccountDetailsPresenterDidFailLogin(in presenter: LoginFetchingAccountDetailsPresenter) {
        self.navigationController.popViewController(animated: true)
    }
}
