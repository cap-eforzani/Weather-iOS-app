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
    
    func makeDeletePreferredCityUseCase() -> DeletePreferredCityUseCase {
        DefaultDeletePreferredCityUseCase(preferredCitiesRepository: makePreferredCitiesRepository())
    }
    
    func makeIsCityAlreadyAddedUseCase() -> IsCityAlreadyAddedUseCase {
        DefaultIsCityAlreadyAddedUseCase(preferredCitiesRepository: makePreferredCitiesRepository())
    }
    
    func makeGetUIImageFromImageRepositoryUseCase() -> GetUIImageFromImageRepositoryUseCase {
        DefaultGetUIImageFromImageRepositoryUseCase(imageRepository: makeImageRepository())
    }
    
    func makeGetPreferredCitiesUseCase() -> GetPreferredCitiesUseCase {
        DefaultGetPreferredCityUseCase(preferredCitiesRepository: makePreferredCitiesRepository())
    }
    
    func makeAddPreferredCityUseCase() -> AddPreferredCityUseCase {
        DefaultAddPreferredCityUseCase(preferredCitiesRepository: makePreferredCitiesRepository())
    }
    
    func makeSearchCitiesUseCase() -> SearchCitiesUseCase {
        DefaultSearchCitiesUseCase(searchCitiesRepository: makeSearchCitiesRepository())
    }
    
    func makeImageRepository() -> ImageRepository {
        DefaultImageRepository()
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
        DefaultPreferredCitiesListViewModel(getPreferredCitiesUseCase: makeGetPreferredCitiesUseCase(), isCityAlreadyAddedUseCase: makeIsCityAlreadyAddedUseCase(), getUIImageFromImageRepositoryUseCase: makeGetUIImageFromImageRepositoryUseCase(), addPreferredCityUseCase: makeAddPreferredCityUseCase(), deletePreferredCityUseCase: makeDeletePreferredCityUseCase(), actions: actions)
    }
    
    func makeAddPreferredCityViewModel(actions: AddPreferredCityViewModelActions) -> AddPreferredCityViewModel {
        DefaultAddPreferredCityViewModel(addPreferredCityUseCase: makeAddPreferredCityUseCase(), deletePreferredCityUseCase: makeDeletePreferredCityUseCase(), searchCitiesUseCase: makeSearchCitiesUseCase(), getUIImageFromImageRepositoryUseCase: makeGetUIImageFromImageRepositoryUseCase(), isCityAlreadyAddedUseCase: makeIsCityAlreadyAddedUseCase(), actions: actions)
    }
    
    func makePreferredCitiesFlowCoordinator(navigationController: UINavigationController) -> PreferredCitiesFlowCoordinator {
        PreferredCitiesFlowCoordinator(navigationController: navigationController, dependencies: self)
    }
}
