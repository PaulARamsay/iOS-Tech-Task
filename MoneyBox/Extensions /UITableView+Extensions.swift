//
//  UITableView+Extensions.swift
//  MoneyBox
//
//  Created by Paul Ramsay on 09/03/2024.
//

import Foundation
import UIKit

extension UITableView {
    
    func register(cells: [NibLoadableCell.Type]) {
        for cell in cells {
            self.register(cell.nib, forCellReuseIdentifier: cell.reuseIdentifier)
        }
    }
    
    func dequeue<T: NibLoadableCell>(cell: T.Type, at indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: T.reuseIdentifier) as! T
    }
}
