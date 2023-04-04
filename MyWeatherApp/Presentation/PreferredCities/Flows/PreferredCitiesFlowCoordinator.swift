//
//  PreferredCitiesFlowCoordinator.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 23/03/2023.
//

import Foundation
import UIKit

protocol PreferredCitiesFlowCoordinatorDependencies {
    func makeAddPreferredCityViewController(actions: AddPreferredCityViewModelActions) -> AddPreferredCityViewController
    func makePreferredCitiesViewController(actions: PreferredCitiesListViewModelActions) -> PreferredCitiesListViewController
    func makeSettingsViewController(actions: SettingsViewModelActions) -> SettingsViewController
}

final class PreferredCitiesFlowCoordinator {
    
    private let navigationController: UINavigationController
    private let dependencies: PreferredCitiesFlowCoordinatorDependencies

    init(navigationController: UINavigationController, dependencies: PreferredCitiesFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let actions = PreferredCitiesListViewModelActions(navigateToSettings: navigateToSettings, navigateToSearchCity: navigateToSearchCity)
        let viewController = dependencies.makePreferredCitiesViewController(actions: actions)
        navigationController.pushViewController(viewController, animated: false)
    }
    
    private func navigateToSearchCity() {
        let actions = AddPreferredCityViewModelActions(navigateToPreviousView: navigateToPreviousView, navigateToSettings: navigateToSettings)
        let viewController = dependencies.makeAddPreferredCityViewController(actions: actions)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func navigateToPreviousView() {
        navigationController.popViewController(animated: true)
    }
    
    func navigateToSettings() {
        let actions = SettingsViewModelActions(navigateToPreviousView: navigateToPreviousView)
        let viewController = dependencies.makeSettingsViewController(actions: actions)
        navigationController.pushViewController(viewController, animated: true)
    }
}
