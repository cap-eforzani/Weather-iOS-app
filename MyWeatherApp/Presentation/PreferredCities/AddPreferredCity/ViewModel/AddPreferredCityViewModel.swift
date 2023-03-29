//
//  AddPreferredCityViewModel.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 23/03/2023.
//

import Foundation

struct AddPreferredCityViewModelActions {
}

protocol AddPreferredCityViewModelInput {
    func didTapSearchButton(searchValue: String) async -> Void
    func getNumberOfCities() -> Int
    func getHeightOfCell() -> CGFloat
}

protocol AddPreferredCityViewModelOutput {
    var noResults: Observable<Bool> { get }
    var isLoading: Observable<Bool> { get }
    var cellDataSource: Observable<[CityTableViewCellViewModel]> { get }
}

typealias AddPreferredCityViewModel = AddPreferredCityViewModelInput & AddPreferredCityViewModelOutput

class DefaultAddPreferredCityViewModel : AddPreferredCityViewModel {
    
    var noResults: Observable<Bool> = Observable(false)
    var isLoading: Observable<Bool> = Observable(false)
    var cellDataSource: Observable<[CityTableViewCellViewModel]> = Observable([])
    var dataSource: Cities?

    private let isCityAlreadyAddedUseCase: IsCityAlreadyAddedUseCase
    private let getIsPreferredImageUseCase: GetIsPreferredImageUseCase
    private let searchCitiesUseCase: SearchCitiesUseCase
    private let addPreferredCityUseCase: AddPreferredCityUseCase
    private let actions: AddPreferredCityViewModelActions?
    private let cellActions: CityTableViewCellViewModelActions?
    
    init(addPreferredCityUseCase: AddPreferredCityUseCase, searchCitiesUseCase: SearchCitiesUseCase, getIsPreferredImageUseCase: GetIsPreferredImageUseCase, isCityAlreadyAddedUseCase: IsCityAlreadyAddedUseCase, actions: AddPreferredCityViewModelActions? = nil, cellActions: CityTableViewCellViewModelActions? = nil) {
        self.addPreferredCityUseCase = addPreferredCityUseCase
        self.searchCitiesUseCase = searchCitiesUseCase
        self.getIsPreferredImageUseCase = getIsPreferredImageUseCase
        self.isCityAlreadyAddedUseCase = isCityAlreadyAddedUseCase
        self.actions = actions
        self.cellActions = cellActions
    }
    
    private func mapCellData() {
        self.cellDataSource.value = self.dataSource?.compactMap({
            DefaultCityTableViewCellViewModel(isCityAlreadyAddedUseCase: isCityAlreadyAddedUseCase, addPreferredCityUseCase: addPreferredCityUseCase, getIsPreferredImageUseCase: getIsPreferredImageUseCase, actions: cellActions, city: $0)
        }) ?? []
    }
    
    private func searchCityByName(name: String) async {
        if (isLoading.value == false) {
            isLoading.value = true
            do {
                let cities = try await searchCitiesUseCase.execute(name: name)
                self.dataSource = cities
                self.isLoading.value = false
                if (cities.isEmpty == true) {
                    self.noResults.value = true
                } else {
                    self.noResults.value = false
                }
            } catch {
                self.dataSource = []
                self.isLoading.value = false
                self.noResults.value = true
            }
            self.mapCellData()
        }
    }
}

extension DefaultAddPreferredCityViewModel {
    
    func getHeightOfCell() -> CGFloat {
        144
    }
    
    func didTapSearchButton(searchValue: String) async {
        await searchCityByName(name: searchValue)
    }
    
    func getNumberOfCities() -> Int {
        return self.dataSource?.count ?? 0
    }
}
