//
//  AddFundsViewController.swift
//  MoneyBox
//
//  Created by Paul Ramsay on 09/03/2024.
//

import UIKit

// MARK: - View Protocol

protocol AddFundsView: AnyObject {
    func update(buttonText: String)
    func update(navigationTitle: String)
    func showAlert(withTitle title: String?, body: String, retryButtonText: String, cancelButtonText: String)
    func showAlert(withTitle title: String?, body: String, ctaTitle: String)
    func updatingLoadingState(loading: Bool)
}

// MARK: - View Controller

class AddFundsViewController: UIViewController {
    
    // Properties (Public)
    
    var presenter: AddFundsPresenting!
    
    // Outlets

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet weak var activityButton: ActivityButton!

    // Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()
        self.navigationItem.setRightBarButton(.init(barButtonSystemItem: .close,
                                                    target: self,
                                                    action: #selector(self.didTapClose)),
                                              animated: true)
        self.tableView.register(cells: [
            LabelTableViewCell.self,
            AmountSelectorTableViewCell.self
        ])
    }
    
    @objc private func didTapClose() {
        self.navigationController?.dismiss(animated: true)
    }
    
    @IBAction private func didTapPrimaryButton() {
        self.presenter.didTapPrimaryButton()
    }
}

// MARK: - AddFundsView

extension AddFundsViewController: AddFundsView {

    func update(navigationTitle: String) {
        self.title = navigationTitle
    }
    
    func showAlert(withTitle title: String?,
                   body: String,
                   ctaTitle: String) {
        let alert = UIAlertController.build(title: title, body: body, ctaTitle: ctaTitle) { _ in
            self.presenter.didTapClose()
        }
        self.present(alert, animated: true)
    }
    
    func showAlert(withTitle title: String?, body: String, retryButtonText: String, cancelButtonText: String) {
        let alert = UIAlertController.build(title: title,
                                            body: body,
                                            retryButtonText: retryButtonText,
                                            cancelButtonText: cancelButtonText,
                                            retryHandler: { _ in
            self.presenter.didTapRetry()
        },
                                            cancelHandler: { _ in
            self.presenter.didTapClose()
        })
                                            
        self.present(alert, animated: true)
    }
    
    func updatingLoadingState(loading: Bool) {
        self.activityButton.showAnimating = loading
    }
    
    func update(buttonText: String) {
        self.activityButton.setTitle(buttonText, for: .normal)
    }
}

// MARK: - UITableViewDataSource

extension AddFundsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        self.presenter.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.presenter.sections[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self.presenter.sections[indexPath.section].rows[indexPath.row] {
        case .title(let title):
            let cell = tableView.dequeue(cell: LabelTableViewCell.self, at: indexPath)
            cell.configure(labelText: title)
            return cell
            
        case .amountSelector(let amount):
            let cell = tableView.dequeue(cell: AmountSelectorTableViewCell.self, at: indexPath)
            cell.configure(startAmount: amount,
                           delegate: self)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        self.presenter.sections[section].title
    }
}

extension AddFundsViewController: AmountSelectorTableViewCellDelegate {
    
    func amountSelectorTableViewCellDidChange(amount: Double,
                                              in cell: AmountSelectorTableViewCell) {
        self.presenter.selectedAmountDidChange(amount: amount)
    }
}
