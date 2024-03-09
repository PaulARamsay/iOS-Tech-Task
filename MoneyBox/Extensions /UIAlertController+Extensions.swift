//
//  UIAlertController+Extensions.swift
//  MoneyBox
//
//  Created by Paul Ramsay on 09/03/2024.
//

import Foundation
import UIKit

extension UIAlertController {
    
    static func build(title: String?,
                      body: String,
                      ctaTitle: String,
                      style: UIAlertController.Style = .alert,
                      handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title, message: body, preferredStyle: style)
        alert.addAction(.init(title: ctaTitle, style: .default, handler: handler))
        return alert
    }
    
    static func build(title: String?,
                      body: String,
                      retryButtonText: String,
                      cancelButtonText: String,
                      retryHandler: ((UIAlertAction) -> Void)?,
                      cancelHandler: ((UIAlertAction) -> Void)?) -> UIAlertController {
        let alert = UIAlertController(title: title, message: body, preferredStyle: .alert)
        alert.addAction(.init(title: cancelButtonText, style: .default, handler: cancelHandler))
        alert.addAction(.init(title: retryButtonText, style: .default, handler: retryHandler))
        return alert
    }
}

