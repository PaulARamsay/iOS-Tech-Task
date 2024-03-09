//
//  Strings.swift
//  MoneyBox
//
//  Created by Paul Ramsay on 09/03/2024.
//

import Foundation

enum Strings {
    
    enum Generic {
        
        enum Alert {
            
            enum Failure {
                static let alertTitle = "Oops, something went wrong"
                static let alertBody = "Error: %@"
                static let retryTitle = "Retry"
                static let cancelTitle = "Cancel"
                static let dismissTitle = "Dismiss"
            }
        }
    }

    enum Login {
        
        enum Standard {
            static let usernameTextfieldTitle = "Email"
            static let passwordTextfieldTitle = "Password"
            static let forgotPasswordTitle = "Forgotten Password"
            static let primaryActionButtonTitle = "Login"
            static let loadingAnnouncement = "Please wait"
        }
    }

    enum AddFunds {
        
        enum Standard {
            static let navTitle = "Add Funds"
            static let ctaTitle = "Add Funds"
            static let planRow = "Plan: %@"
            static let moneyBoxRow = "Moneybox: %@"
            static let planValue = "Plan Value: %@"
            
            enum SuccessAlert {
                static let alertTitle = "Success"
                static let alertBody = "Your new account value is %@"
                static let ctaTitle = "Okay"
            }
        }
    }
    
    enum Accounts {
        
        enum HeaderSection {
            static let sectionTitle = "Accounts"
            static let personalisedNameplate = "Hello %@"
            static let totalPlanValue = "Total plan value: %@"
        }

        enum Standard {
            static let planRow = "Plan: %@"
            static let moneyBoxRow = "Moneybox: %@"
            static let planValue = "Plan Value: %@"
        }
    }
    
    enum FetchinAccountDetails {
        static let alertTitle = "Oops, something went wrong"
        static let alertBody = "Error: %@"
        static let retryTitle = "Retry"
        static let cancelTitle = "Cancel"
    }
    
    enum Debug {
        
        enum NotImplemented {
            static let alertTitle = "Not Implemented"
            static let alertBody = "Try again later"
            static let ctaTitle = "Okay"
        }
    }
}
