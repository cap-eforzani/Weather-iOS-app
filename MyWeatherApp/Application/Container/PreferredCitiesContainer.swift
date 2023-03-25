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
        let api: OpenWeatherAPI
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
    
    func makeSearchCitiesUseCase() -> SearchCitiesUseCase {
        DefaultSearchCitiesUseCase(searchCitiesRepository: makeSearchCitiesRepository())
    }
    
    func makePreferredCitiesRepository() -> PreferredCitiesRepository {
        DefaultPreferredCitiesRepository()
    }
    
    func makeSearchCitiesRepository() -> SearchCitiesRepository {
        DefaultSearchCitiesRepository(api: dependencies.api)
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
        DefaultAddPreferredCityViewModel(addPreferredCityUseCase: makeAddPreferredCityUseCase(), searchCitiesUseCase: makeSearchCitiesUseCase(), actions: actions)
    }
    
    func makePreferredCitiesFlowCoordinator(navigationController: UINavigationController) -> PreferredCitiesFlowCoordinator {
        PreferredCitiesFlowCoordinator(navigationController: navigationController, dependencies: self)
    }
}