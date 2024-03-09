//
//  LoginFetchingAccountDetailsViewController.swift
//  MoneyBox
//
//  Created by Paul Ramsay on 09/03/2024.
//

import UIKit

// MARK: - View Protocol

protocol LoginFetchinAccountDetailsView: AnyObject {
    func showAlert(withTitle title: String?,
                   body: String,
                   retryButtonText: String,
                   cancelButtonText: String)
}

//MARK: - View Controller

class LoginFetchingAccountDetailsViewController: UIViewController {

    // MARK: - Properties

    var presenter: LoginFetchingAccountDetailsPresenting!
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
    }
}

// MARK: - LoginFetchingAccountDetailsPresenting

extension LoginFetchingAccountDetailsViewController: LoginFetchinAccountDetailsView {
    
    func showAlert(withTitle title: String?,
                   body: String,
                   retryButtonText: String,
                   cancelButtonText: String) {
        let alert = UIAlertController.build(title: title,
                                            body: body,
                                            retryButtonText: retryButtonText,
                                            cancelButtonText: cancelButtonText) { _ in
            self.presenter.didTapRetry()
        } cancelHandler: { _ in
            self.presenter.didTapCancel()
        }

        
        self.navigationController?.present(alert, animated: true)
    }
    
    func announce(message: String) {
        UIAccessibility.post(notification: .announcement, argument: message)
    }
}
