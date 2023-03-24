//
//  PreferredCitiesListViewModel.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 22/03/2023.
//

import Foundation

struct PreferredCitiesListViewModelActions {
    let showAddPreferredCity: () -> Void
}

protocol PreferredCitiesListViewModelInput {
    func getNumberOfPreferredCities() -> Int
    func didTapFloatingButton() -> Void
}

protocol PreferredCitiesListViewModelOutput {
    var screenTitle: String { get }
}

typealias PreferredCitiesListViewModel = PreferredCitiesListViewModelInput & PreferredCitiesListViewModelOutput

class DefaultPreferredCitiesListViewModel : PreferredCitiesListViewModel {

    private let getPreferredCitiesUseCase: GetPreferredCityUseCase
    private let actions: PreferredCitiesListViewModelActions?
    
    let screenTitle = "My Preferred Cities"
    
    init(getPreferredCitiesUseCase: GetPreferredCityUseCase, actions: PreferredCitiesListViewModelActions? = nil) {
        self.getPreferredCitiesUseCase = getPreferredCitiesUseCase
        self.actions = actions
    }
}

extension DefaultPreferredCitiesListViewModel {
    
    func didTapFloatingButton() {
        actions?.showAddPreferredCity()
    }

    func getNumberOfPreferredCities() -> Int {
        do {
            return try getPreferredCitiesUseCase.execute()
        } catch {
            return 0
        }
    }
}
