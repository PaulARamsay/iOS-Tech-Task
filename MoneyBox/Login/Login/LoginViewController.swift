//
//  LoginViewController.swift
//  MoneyBox
//
//  Created by Zeynep Kara on 16.01.2022.
//

import UIKit

// MARK: - View Protocol

protocol LoginView: AnyObject {
    func showAlert(withTitle title: String?, body: String, ctaTitle: String)
    func updateButtonState(isEnabled enabled: Bool)
    func update(emailTextfieldTitle: String,
                passwordTextfieldTitle: String,
                primaryActionButtonText: String,
                secondaryActionButtonText: String)
    func updatingLoadingState(loading: Bool)
    func announce(message: String)
}

// MARK: - View Controller

class LoginViewController: UIViewController {
    
    // Properties - (Public)
    
    var presenter: LoginPresenting!
    
    // Properties - (Private)
    
    private var keyboardAvoider = KeyboardAvoider()
    
    // Outputs
    
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var passwordLabel: UILabel!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextfield: UITextField!
    @IBOutlet private weak var primaryActionButton: ActivityButton!
    @IBOutlet private weak var forgotPasswordButton: UIButton!
    
    var activitiyIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        self.presenter.viewDidLoad()
        self.keyboardAvoider.setupFor(view: self.view)
        self.emailTextField.tag = LocalConstants.Textfield.email.rawValue
        self.passwordTextfield.tag = LocalConstants.Textfield.password.rawValue
    }
    
    @IBAction private func didTapPrimaryActionButton() {
        self.presenter.didTapPrimaryButton()
    }
    
    @IBAction private func didTapForgotPasswordButton() {
        self.presenter.didTapForgottenPassword()
    }

    @IBAction private func textfieldDidChange(_ sender: UITextField) {
        let textfield = LocalConstants.Textfield.init(rawValue: sender.tag)
        switch textfield {
        case .email:
            self.presenter.didUpdateUsernameField(withString: sender.text)
        
        case .password:
            self.presenter.didUpdatePasswordField(withString: sender.text)

        default:
            break
        }
    }
}

// MARK: - LoginView

extension LoginViewController: LoginView {
    
    func announce(message: String) {
        UIAccessibility.post(notification: .announcement, argument: message)
    }
    
    func update(emailTextfieldTitle: String,
                passwordTextfieldTitle: String,
                primaryActionButtonText: String,
                secondaryActionButtonText: String) {
        self.emailLabel.text = emailTextfieldTitle
        self.passwordLabel.text = passwordTextfieldTitle
        self.primaryActionButton.setTitle(primaryActionButtonText, for: .normal)
        self.forgotPasswordButton.setTitle(secondaryActionButtonText, for: .normal)
    }
    
    func updatingLoadingState(loading: Bool) {
        self.primaryActionButton.showAnimating = loading
    }
    
    
    func showAlert(withTitle title: String?, body: String, ctaTitle: String) {
        let alert = UIAlertController.build(title: title, body: body, ctaTitle: ctaTitle)
        self.navigationController?.present(alert, animated: true)
    }
    
    func updateButtonState(isEnabled enabled: Bool) {
        self.primaryActionButton.isEnabled = enabled
    }
}

// MARK: - LocalConstants

extension LoginViewController {
    
    enum LocalConstants {
        
        static var activityIndicatorOffset: CGFloat = -25
        
        enum Textfield: Int {
            case email
            case password
        }
    }
}
