//
//  PreferredCitiesContainer.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 23/03/2023.
//

import Foundation
import UIKit

final class PreferredCitiesContainer: PreferredCitiesFlowCoordinatorDependencies {

    struct Dependencies {
        let test: String
    }
    
    private let dependencies : Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func makeGetPreferredCitiesUseCase() -> GetPreferredCityUseCase {
        DefaultGetPreferredCityUseCase(preferredCitiesRepository: makePreferredCitiesRepository())
    }
    
    func makeAddPreferredCityUseCase() -> AddPreferredCityUseCase {
        DefaultAddPreferredCityUseCase(preferredCitiesRepository: makePreferredCitiesRepository())
    }
    
    func makePreferredCitiesRepository() -> PreferredCitiesRepository {
        DefaultPreferredCitiesRepository()
    }
    
    func makePreferredCitiesViewController(actions: PreferredCitiesListViewModelActions) -> PreferredCitiesListViewController {
        PreferredCitiesListViewController.create(with: makePreferredCitiesViewModel(actions: actions))
    }
    
    func makeAddPreferredCityViewController(actions: AddPreferredCityViewModelActions) -> AddPreferredCityViewController {
        AddPreferredCityViewController.create(with: makeAddPreferredCityViewModel(actions: actions))
    }
    
    func makePreferredCitiesViewModel(actions: PreferredCitiesListViewModelActions) -> PreferredCitiesListViewModel {
        DefaultPreferredCitiesListViewModel(getPreferredCitiesUseCase: makeGetPreferredCitiesUseCase(), actions: actions)
    }
    
    func makeAddPreferredCityViewModel(actions: AddPreferredCityViewModelActions) -> AddPreferredCityViewModel {
        DefaultAddPreferredCityViewModel(addPreferredCityUseCase: makeAddPreferredCityUseCase(), actions: actions)
    }
    
    func makePreferredCitiesFlowCoordinator(navigationController: UINavigationController) -> PreferredCitiesFlowCoordinator {
        PreferredCitiesFlowCoordinator(navigationController: navigationController, dependencies: self)
    }
}
