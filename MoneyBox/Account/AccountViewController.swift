//
//  AccountViewController.swift
//  MoneyBox
//
//  Created by Paul Ramsay on 09/03/2024.
//

import UIKit

// View Protocol

protocol AccountView: AnyObject {
    func update(title: String)
}

// MARK: - View

class AccountViewController: UIViewController {
    
    // Outlets
    
    @IBOutlet private weak var tableView: UITableView!
    
    // Properties
    
    var presenter: AccountPresenting!

    // Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(cells: [
            LabelTableViewCell.self,
            ProductTableViewCell.self
        ])

        self.presenter.viewDidLoad()
    }
}

// MARK: - UITableViewDelegate

extension AccountViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        self.presenter.didTapItemAt(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        self.presenter.sections[section].title
    }
}

// MARK: - UITableViewDataSource

extension AccountViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.sections[section].rows.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.presenter.sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self.presenter.sections[indexPath.section].rows[indexPath.row] {

        case .product(let accountTitle, let planValue, let moneyboxValue, _):
            let cell = tableView.dequeue(cell: ProductTableViewCell.self,
                                         at: indexPath)
            cell.configure(title: accountTitle,
                           body: planValue,
                           supplementaryLabel: moneyboxValue)
            return cell
            
        case .title(let title):
            let cell = tableView.dequeue(cell: LabelTableViewCell.self, at: indexPath)
            cell.configure(labelText: title)
            return cell
        }
    }
}

// MARK: - AccountView

extension AccountViewController: AccountView {
    
    func update(title: String) {
        self.title = title
    }
}
