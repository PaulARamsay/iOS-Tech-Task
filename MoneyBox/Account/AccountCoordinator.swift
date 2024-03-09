//
//  AccountCoordinator.swift
//  MoneyBox
//
//  Created by Paul Ramsay on 09/03/2024.
//

import Foundation
import UIKit
import Networking

// Coordinator

class AccountCoordinator: Coordinator {
    
    // Properties
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var apiSession: APISessionable
    
    var accountResponse: AccountResponse!
    
    // MARK: - Initialiser
    
    init(navigationController: UINavigationController,
         accountResponse: AccountResponse,
         apiSession: APISessionable) {
        self.navigationController = navigationController
        self.accountResponse = accountResponse
        self.apiSession = apiSession
    }
    
    // Helpers
    
    func start() {
        let view = AccountViewController()
        let presenter = AccountPresenter(view: view,
                                         accountDetails: self.accountResponse,
                                         delegate: self,
                                         apiSession: self.apiSession)
        view.presenter = presenter
        self.navigationController.viewControllers = [view]
    }
    
    private func navigateToAddFunds(product: ProductResponse) {
        let view = AddFundsViewController()
        let presenter = AddFundsPresenter(view: view,
                                          delegate: self,
                                          productResponse: product,
                                          apiSession: self.apiSession)
        view.presenter = presenter
        let navigationController = UINavigationController(rootViewController: view)
        self.navigationController.present(navigationController,
                                          animated: true)
        
    }
}

// MARK: - AddFundsPresenterDelegate

extension AccountCoordinator: AddFundsPresenterDelegate {
    
    func addFundsPresenterDidWillClose(in presenter: AddFundsPresenter) {
        self.navigationController.dismiss(animated: true)
    }
}

// MARK: - AccountPresenterDelegate

extension AccountCoordinator: AccountPresenterDelegate {
    
    func accountPresenterDidTap(product: ProductResponse, in presenter: AccountPresenter) {
        self.navigateToAddFunds(product: product)
    }
}
