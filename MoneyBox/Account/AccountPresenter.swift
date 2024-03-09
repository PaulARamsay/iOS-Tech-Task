//
//  AccountPresenter.swift
//  MoneyBox
//
//  Created by Paul Ramsay on 09/03/2024.
//

import Foundation
import Networking

// MARK: - Presenter Protocol

protocol AccountPresenting: AnyObject {
    var sections: [AccountPresenter.ViewModel.Section] { get }
    
    func viewDidLoad()
    func didTapItemAt(indexPath: IndexPath)
}

// MARK: - Delegate

protocol AccountPresenterDelegate: AnyObject {
    func accountPresenterDidTap(product: ProductResponse, in presenter: AccountPresenter)
}

// MARK: - Presenter

class AccountPresenter {
    
    // Properties (Private) 
    
    let accountDetails: AccountResponse
    let apiSession: APISessionable
    
    // Properties (Public)
    
    weak var view: AccountView!
    weak var delegate: AccountPresenterDelegate!
    
    // Initialiser
    
    init(view: AccountView,
         accountDetails: AccountResponse,
         delegate: AccountPresenterDelegate,
         apiSession: APISessionable) {
        self.accountDetails = accountDetails
        self.view = view
        self.delegate = delegate
        self.apiSession = apiSession
    }
}

extension AccountPresenter {
    
    struct ViewModel {
        
        struct Section {
            let title: String?
            let rows: [Row]
        }
        
        enum Row {
            case title(title: String)
            case product(accountTitle: String,
                         planValue: String,
                         moneyBoxValue: String,
                         product: ProductResponse)
        }
    }
}

// MARK: - AccountPresenting

extension AccountPresenter: AccountPresenting {
    
    func viewDidLoad() {
        self.view.update(title: Strings.Accounts.HeaderSection.sectionTitle)
    }
    
    var sections: [ViewModel.Section] {
        var sections: [ViewModel.Section] = []
        
        self.accountDetails.productResponses?.forEach {
            let accountTitle = $0.product?.name ?? ""
            let planValue = $0.planValue ?? 0
            let moneyBoxValue = $0.moneybox ?? 0
            

            sections.append(.init(title: nil,
                                  rows: [
                                    .product(accountTitle: Strings.Accounts.Standard.planRow.localized(withValue: accountTitle),
                                             planValue: Strings.Accounts.Standard.planValue.localized(withValue: planValue.asAmount().formattedAmount()),
                                             moneyBoxValue: Strings.Accounts.Standard.moneyBoxRow.localized(withValue: moneyBoxValue.asAmount().formattedAmount()),
                                             product: $0)
                              ]))
        }
        
        sections.insert(.init(title: Strings.Accounts.HeaderSection.sectionTitle,
                              rows: [
                                .title(title: Strings.Accounts.HeaderSection.personalisedNameplate.localized(withValue: self.apiSession.user?.firstName ?? "")),
                                .title(title: Strings.Accounts.HeaderSection.totalPlanValue.localized(withValue: self.accountDetails.totalPlanValue.asAmount().formattedAmount()))
                        ]),
                        at: 0)
        
        return sections
    }
    
    func didTapItemAt(indexPath: IndexPath) {
        let row = self.sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .product(_, _, _, let product):
            self.delegate.accountPresenterDidTap(product: product, in: self)
            
        default:
            break
        }
    }
}
