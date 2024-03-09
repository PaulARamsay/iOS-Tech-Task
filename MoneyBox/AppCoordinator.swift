//
//  AppCoordinator.swift
//  MoneyBox
//
//  Created by Paul Ramsay on 09/03/2024.
//

import Foundation

import UIKit
import Networking

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}

class AppCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var window: UIWindow
    
    var apiSession: APISessionable = APISession()

    init(window: UIWindow, UINavigationController: UINavigationController = UINavigationController()) {
        self.window = window
        self.navigationController = UINavigationController
        self.window.rootViewController = self.navigationController
        self.navigationController.setNavigationBarHidden(true, animated: false)
        self.window.makeKeyAndVisible()
    }

    func start() {
        let loginCoordinator = LoginCoordinator(navigationController: self.navigationController,
                                                delegate: self)
        self.childCoordinators.append(loginCoordinator)
        loginCoordinator.start()
    }
    
    private func setupTabBar(accountDetails: AccountResponse) {
        let tabBar = UITabBarController()
        
        let coordinator = self.accountCoordinator(accountDetails: accountDetails)
        
        tabBar.viewControllers = [coordinator.navigationController]
        
        
        self.navigationController.viewControllers = [tabBar]
    }
    
    private func accountCoordinator(accountDetails: AccountResponse) -> AccountCoordinator {
        let navigationController = UINavigationController()
        let coordinator = AccountCoordinator(navigationController: navigationController,
                                             accountResponse: accountDetails,
                                             apiSession: self.apiSession)
        self.childCoordinators.append(coordinator)
        coordinator.start()
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.tabBarItem = .init(title: "Account",
                                                image: UIImage(systemName: "person"),
                                                selectedImage: nil)
        return coordinator
    }
}

extension AppCoordinator: LoginCoordinatorDelegate {
    
    func loginCoordinatorDidLoginSuccessfully(withApiSession apiSession: APISessionable,
                                              accountDetails: AccountResponse) {
        self.apiSession = apiSession
        self.setupTabBar(accountDetails: accountDetails)
    }
}
