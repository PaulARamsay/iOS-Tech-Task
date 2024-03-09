//
//  AddFundsPresenter.swift
//  MoneyBox
//
//  Created by Paul Ramsay on 09/03/2024.
//

import Foundation
import Networking

// MARK: - Presenter Protocol

protocol AddFundsPresenting: AnyObject {
    var sections: [AddFundsPresenter.ViewModel.Section] { get }
    
    func viewDidLoad()
    func didTapPrimaryButton()
    func selectedAmountDidChange(amount: Double)
    func didTapClose()
    func didTapRetry()
}

// MARK: - Delegate

protocol AddFundsPresenterDelegate: AnyObject {
    func addFundsPresenterDidWillClose(in presenter: AddFundsPresenter)
}

// MARK: - Presenter

class AddFundsPresenter {
    
    // Properties (Private)
    
    private let productResponse: ProductResponse
    private let apiSession: APISessionable
    private let dataProvider: DataProviderLogic
    
    private var amount: Double = LocalConstants.amount
    
    // Properties (Public)
    
    weak var view: AddFundsView!
    weak var delegate: AddFundsPresenterDelegate!
    
    // Initialiser
    
    init(view: AddFundsView,
         delegate: AddFundsPresenterDelegate,
         productResponse: ProductResponse,
         apiSession: APISessionable,
         dataProvider: DataProviderLogic = DataProvider()) {
        self.view = view
        self.delegate = delegate
        self.productResponse = productResponse
        self.apiSession = apiSession
        self.dataProvider = dataProvider
    }
    
    // Helpers
    
    func addFundsToAccount() {
        guard let fundId = self.productResponse.id else { return }
        self.view.updatingLoadingState(loading: true)

        let request = OneOffPaymentRequest(amount: Int(self.amount),
                                           investorProductID: fundId)
        
        self.dataProvider.addMoney(request: request) { [weak self] result in
            guard let self = self else { return }
            self.view.updatingLoadingState(loading: false)

            switch result {
            case .success(let successResult):
                self.view.showAlert(withTitle: Strings.AddFunds.Standard.SuccessAlert.alertTitle,
                                    body: Strings.AddFunds.Standard.SuccessAlert.alertBody.localized(withValue: String(describing: successResult.moneybox?.asAmount().formattedAmount())),
                                    ctaTitle: Strings.AddFunds.Standard.SuccessAlert.ctaTitle)
                
            case .failure(let error):
                self.view.showAlert(withTitle: Strings.Generic.Alert.Failure.alertTitle,
                                    body: Strings.Generic.Alert.Failure.alertBody.localized(withValue: error.localizedDescription),
                                    retryButtonText: Strings.Generic.Alert.Failure.retryTitle,
                                    cancelButtonText: Strings.Generic.Alert.Failure.cancelTitle)
            }
        }
    }
}

// MARK: - ViewModel

extension AddFundsPresenter {
    
    struct ViewModel {
        
        struct Section {
            let title: String?
            let rows: [Row]
        }
        
        enum Row {
            case title(title: String)
            case amountSelector(amount: Double)
        }
    }
}

// MARK: - AddFundsPresenting

extension AddFundsPresenter: AddFundsPresenting {

    var sections: [AddFundsPresenter.ViewModel.Section] {

        let thisProductResponse = self.productResponse
        let product = thisProductResponse.product
        
        let friendlyName = product?.friendlyName ?? ""
        let accountTitle = product?.name ?? ""
        let planValue = thisProductResponse.planValue?.asAmount().formattedAmount() ?? ""
        let moneyBoxValue = thisProductResponse.moneybox?.asAmount().formattedAmount() ?? ""
        
        return [
            .init(title: friendlyName,
                  rows: [
                    .title(title: Strings.AddFunds.Standard.planRow.localized(withValue: accountTitle)),
                    .title(title: Strings.AddFunds.Standard.planValue.localized(withValue: planValue)),
                    .title(title: Strings.AddFunds.Standard.moneyBoxRow.localized(withValue: moneyBoxValue))
                  ]),
            .init(title: nil,
                  rows: [
                    .amountSelector(amount: LocalConstants.amount)
                  ])
        ]
    }
    
    func viewDidLoad() {
        self.view.update(buttonText: Strings.AddFunds.Standard.ctaTitle)
        self.view.update(navigationTitle: Strings.AddFunds.Standard.navTitle)
    }
    
    func didTapPrimaryButton() {
        self.addFundsToAccount()
    }
    
    func selectedAmountDidChange(amount: Double) {
        self.amount = amount
    }
    
    func didTapClose() {
        self.delegate.addFundsPresenterDidWillClose(in: self)
    }
    
    func didTapRetry() {
        self.addFundsToAccount()
    }
}

// MARK: - LocalConstants

extension AddFundsPresenter {
    
    enum LocalConstants {
        static let amount: Double = 5
    }
}
