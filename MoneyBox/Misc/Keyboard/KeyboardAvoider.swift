//
//  KeyboardAvoider.swift
//  MoneyBox
//
//  Created by Paul Ramsay on 09/03/2024.
//

import Foundation
import UIKit

/// An easy to use class that allows you to avoid the content of the screen the frame up. Sadly we still need this until SwiftUI!

class KeyboardAvoider {
    
    // Properties - (Private)
        
    private var keyboardHeight: CGFloat = 0
    private var view: UIView?
    
    // Properties - Configure
    
    func setupFor(view: UIView) {
        
        self.view = view
                
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillDisappear),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillAppear),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
    }
    
    @objc func keyboardWillAppear(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            guard self.keyboardHeight == 0 else { return }

            let keyboardRectangle = keyboardFrame.cgRectValue
            self.keyboardHeight = keyboardRectangle.height
                        
            self.view?.window?.frame.origin.y -= self.keyboardHeight
        }
    }
    
    @objc func keyboardWillDisappear(_ notification: Notification) {
        self.view?.window?.frame.origin.y += self.keyboardHeight
        self.keyboardHeight = 0
    }

}
