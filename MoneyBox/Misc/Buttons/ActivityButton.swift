//
//  ActivityButton.swift
//  MoneyBox
//
//  Created by Paul Ramsay on 09/03/2024.
//

import Foundation
import UIKit

@IBDesignable
final class ActivityButton: UIButton {
    
    // properties (private)
    
    private var activityIndicator: UIActivityIndicatorView?
    
    // properties (public)
    
    override var isEnabled: Bool {
        didSet {
            self.updateButtonBackground()
        }
    }
    
    var showAnimating: Bool = false {
        didSet {
            self.configureActivityIndicator(showAnimating: showAnimating)
        }
    }
    
    
    // Intialisers

    override init(frame: CGRect){
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.setup()
    }

    func setup() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 5
        self.updateButtonBackground()
    }
    
    // MARK: - Helpers
    
    func updateButtonBackground() {
        self.backgroundColor = self.isEnabled ? UIColor(named: "AccentColor") : .lightGray
        self.titleLabel?.textColor = self.isEnabled ? .white : .lightText
    }
    
    func configureActivityIndicator(showAnimating: Bool) {
        self.activityIndicator?.removeFromSuperview()
        let activityIndicator = UIActivityIndicatorView()
        self.activityIndicator = activityIndicator
        self.addSubview(activityIndicator)
        self.activityIndicator?.translatesAutoresizingMaskIntoConstraints = false
        self.activityIndicator?.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.activityIndicator?.centerXAnchor.constraint(equalTo: self.rightAnchor,
                                                         constant: LocalConstants.activityIndicatorOffset).isActive = true
        self.activityIndicator?.color = .white
        showAnimating ? self.activityIndicator?.startAnimating() : self.activityIndicator?.stopAnimating()
    }
}

//MARK: - LocalConstants

extension ActivityButton {
    
    enum LocalConstants {
        static var activityIndicatorOffset: CGFloat = -25
    }
}
        
