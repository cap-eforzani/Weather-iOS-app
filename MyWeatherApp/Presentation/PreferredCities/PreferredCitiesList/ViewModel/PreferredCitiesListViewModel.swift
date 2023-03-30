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
    func getHeightOfCell() -> CGFloat
    func getPreferredCities() -> Void
    func getNumberOfPreferredCities() -> Int
    func didTapFloatingButton() -> Void
    
}

protocol PreferredCitiesListViewModelOutput {
    var screenTitle: String { get }
    var noResults: Observable<Bool> { get }
    var cellDataSource: Observable<[CityTableViewCellViewModel]> { get }
    var isLoading: Observable<Bool> { get }
}

typealias PreferredCitiesListViewModel = PreferredCitiesListViewModelInput & PreferredCitiesListViewModelOutput

class DefaultPreferredCitiesListViewModel : PreferredCitiesListViewModel {

    var noResults: Observable<Bool> = Observable(false)
    var cellDataSource: Observable<[CityTableViewCellViewModel]> = Observable([])
    var isLoading: Observable<Bool> = Observable(false)
    var dataSource: Cities?
    
    private let getPreferredCitiesUseCase: GetPreferredCitiesUseCase
    private let deletePreferredCityUseCase: DeletePreferredCityUseCase
    private let isCityAlreadyAddedUseCase: IsCityAlreadyAddedUseCase
    private let getUIImageFromImageRepositoryUseCase: GetUIImageFromImageRepositoryUseCase
    private let addPreferredCityUseCase: AddPreferredCityUseCase

    private let actions: PreferredCitiesListViewModelActions?
    
    let screenTitle = "My Preferred Cities"
    
    init(getPreferredCitiesUseCase: GetPreferredCitiesUseCase, isCityAlreadyAddedUseCase: IsCityAlreadyAddedUseCase, getUIImageFromImageRepositoryUseCase: GetUIImageFromImageRepositoryUseCase, addPreferredCityUseCase: AddPreferredCityUseCase, deletePreferredCityUseCase: DeletePreferredCityUseCase, actions: PreferredCitiesListViewModelActions? = nil) {
        self.getPreferredCitiesUseCase = getPreferredCitiesUseCase
        self.isCityAlreadyAddedUseCase = isCityAlreadyAddedUseCase
        self.getUIImageFromImageRepositoryUseCase = getUIImageFromImageRepositoryUseCase
        self.addPreferredCityUseCase = addPreferredCityUseCase
        self.deletePreferredCityUseCase = deletePreferredCityUseCase
        self.actions = actions
    }
    
    private func mapCellData() {
        self.cellDataSource.value = self.dataSource?.compactMap({
            DefaultPreferredCitiesTableViewCellViewModel(deletePreferredCityUseCase: deletePreferredCityUseCase, getUIImageFromImageRepositoryUseCase: getUIImageFromImageRepositoryUseCase, city: $0, actions: PreferredCitiesTableViewCellViewModelActions(getPreferredCities: self.getPreferredCities))
        }) ?? []
    }
}

extension DefaultPreferredCitiesListViewModel {

    func getHeightOfCell() -> CGFloat {
        144
    }
    
    func didTapFloatingButton() {
        actions?.showAddPreferredCity()
    }
    
    func getPreferredCities() {
        do {
            if (isLoading.value == false) {
                isLoading.value = true
                self.dataSource = try getPreferredCitiesUseCase.execute()
                self.mapCellData()
                isLoading.value = false
                if (dataSource?.isEmpty == true) {
                    noResults.value = true
                } else {
                    noResults.value = false
                }
            }
        } catch {
            print("[ERROR] Unable to retrieve preferred cities")
        }
    }

    func getNumberOfPreferredCities() -> Int {
        return self.dataSource?.count ?? 0
    }
}
