//
//  PreferredCitiesFlowCoordinator.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 23/03/2023.
//

import Foundation
import UIKit

protocol PreferredCitiesFlowCoordinatorDependencies {
    func makeAddPreferredCityViewController(navigationBar: NavigationBarViewModel, actions: AddPreferredCityViewModelActions) -> AddPreferredCityViewController
    func makePreferredCitiesViewController(navigationBar: NavigationBarViewModel, actions: PreferredCitiesListViewModelActions) -> PreferredCitiesListViewController
    func makeSettingsViewController(navigationBar: NavigationBarViewModel, actions: SettingsViewModelActions?) -> SettingsViewController
    func makeNavigationBarViewModel(actions: NavigationBarViewModelActions, title: String) -> NavigationBarViewModel
}

final class PreferredCitiesFlowCoordinator {
    
    private let navigationController: UINavigationController
    private let dependencies: PreferredCitiesFlowCoordinatorDependencies

    init(navigationController: UINavigationController, dependencies: PreferredCitiesFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let actions = PreferredCitiesListViewModelActions(showAddPreferredCity: showAddPreferredCity)
        let navigationBar = getDefaultNavigationBar(title: "My Preferred Cities")
        let viewController = dependencies.makePreferredCitiesViewController(navigationBar: navigationBar, actions: actions)
        navigationController.pushViewController(viewController, animated: false)
    }
    
    private func showAddPreferredCity() {
        let actions = AddPreferredCityViewModelActions()
        let navigationBar = getDefaultNavigationBar(title: "Search for a City")
        let viewController = dependencies.makeAddPreferredCityViewController(navigationBar: navigationBar, actions: actions)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func getDefaultNavigationBar(title: String) -> NavigationBarViewModel {
        let navigationBarActions = NavigationBarViewModelActions(didTapBackButton: navigateToPreviousView, didTapRightButton: navigateToSettingsView)
        return dependencies.makeNavigationBarViewModel(actions: navigationBarActions, title: title)
    }
    
    func navigateToPreviousView() {
        navigationController.popViewController(animated: true)
    }
    
    func navigateToSettingsView() {
        let actions = SettingsViewModelActions()
        let navigationBar = getDefaultNavigationBar(title: "Settings")
        let viewController = dependencies.makeSettingsViewController(navigationBar: navigationBar, actions: actions)
        navigationController.pushViewController(viewController, animated: true)
    }
}
