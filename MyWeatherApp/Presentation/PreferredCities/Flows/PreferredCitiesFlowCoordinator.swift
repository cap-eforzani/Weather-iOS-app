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
        let viewController = dependencies.makePreferredCitiesViewController(actions: actions)
        navigationController.pushViewController(viewController, animated: false)
    }
    
    private func showAddPreferredCity() {
        let actions = AddPreferredCityViewModelActions(showPreferredCities: showPreferredCities)
        let viewController = dependencies.makeAddPreferredCityViewController(actions: actions)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func showPreferredCities() {
        navigationController.popViewController(animated: true)
    }
}
