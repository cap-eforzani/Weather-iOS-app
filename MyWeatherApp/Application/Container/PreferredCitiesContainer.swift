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
    
    func makeSetShowLattitudeAndLongitudeSettingUseCase() -> SetShowLattitudeAndLongitudeUseCase {
        DefaultSetShowLattitudeAndLongitudeUseCase(userDefaultsRepository: makeUserDefaultsRepository())
    }
    
    func makeGetShowLattitudeAndLongitudeSettingUseCase() -> GetShowLattitudeAndLongitudeUseCase {
        DefaultGetShowLattitudeAndLongitudeUseCase(userDefaultsRepository: makeUserDefaultsRepository())
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
    
    func makeUserDefaultsRepository() -> UserDefaultsRepository {
        DefaultUserDefaultsRepository()
    }
    
    func makePreferredCitiesRepository() -> PreferredCitiesRepository {
        DefaultPreferredCitiesRepository()
    }
    
    func makeSearchCitiesRepository() -> SearchCitiesRepository {
        DefaultSearchCitiesRepository(api: dependencies.api)
    }
    
    func makeSettingsViewController(navigationBar: NavigationBarViewModel, actions: SettingsViewModelActions? = nil) -> SettingsViewController {
        SettingsViewController.create(with: makeSettingsViewModel(actions: actions), navigationBar: navigationBar)
    }
    
    func makePreferredCitiesViewController(navigationBar: NavigationBarViewModel, actions: PreferredCitiesListViewModelActions) -> PreferredCitiesListViewController {
        PreferredCitiesListViewController.create(with: makePreferredCitiesViewModel(actions: actions), navigationBar: navigationBar)
    }
    
    func makeAddPreferredCityViewController(navigationBar: NavigationBarViewModel, actions: AddPreferredCityViewModelActions) -> AddPreferredCityViewController {
        AddPreferredCityViewController.create(with: makeAddPreferredCityViewModel(actions: actions), navigationBar: navigationBar)
    }
    
    func makeSettingsViewModel(actions: SettingsViewModelActions? = nil) -> SettingsViewModel {
        DefaultSettingsViewModel(getShowLattitudeAndLongitudeSettingUseCase: makeGetShowLattitudeAndLongitudeSettingUseCase(), setShowLattitudeAndLongitudeSettingUseCase: makeSetShowLattitudeAndLongitudeSettingUseCase(), actions: actions)
    }
    
    func makeNavigationBarViewModel(actions: NavigationBarViewModelActions, title: String) -> NavigationBarViewModel {
        DefaultNavigationBarViewModel(actions: actions, title: title)
    }
    
    func makePreferredCitiesViewModel(actions: PreferredCitiesListViewModelActions) -> PreferredCitiesListViewModel {
        DefaultPreferredCitiesListViewModel(getPreferredCitiesUseCase: makeGetPreferredCitiesUseCase(), isCityAlreadyAddedUseCase: makeIsCityAlreadyAddedUseCase(), getUIImageFromImageRepositoryUseCase: makeGetUIImageFromImageRepositoryUseCase(), addPreferredCityUseCase: makeAddPreferredCityUseCase(), deletePreferredCityUseCase: makeDeletePreferredCityUseCase(), getShowLattitudeAndLongitudeUseCase: makeGetShowLattitudeAndLongitudeSettingUseCase(), actions: actions)
    }
    
    func makeAddPreferredCityViewModel(actions: AddPreferredCityViewModelActions) -> AddPreferredCityViewModel {
        DefaultAddPreferredCityViewModel(addPreferredCityUseCase: makeAddPreferredCityUseCase(), deletePreferredCityUseCase: makeDeletePreferredCityUseCase(), searchCitiesUseCase: makeSearchCitiesUseCase(), getUIImageFromImageRepositoryUseCase: makeGetUIImageFromImageRepositoryUseCase(), isCityAlreadyAddedUseCase: makeIsCityAlreadyAddedUseCase(), getShowLattitudeAndLongitudeUseCase: makeGetShowLattitudeAndLongitudeSettingUseCase(), actions: actions)
    }
    
    func makePreferredCitiesFlowCoordinator(navigationController: UINavigationController) -> PreferredCitiesFlowCoordinator {
        PreferredCitiesFlowCoordinator(navigationController: navigationController, dependencies: self)
    }
}
