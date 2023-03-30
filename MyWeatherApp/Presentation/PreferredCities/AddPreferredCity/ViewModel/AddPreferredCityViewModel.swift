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

    private let deletePreferredCityUseCase: DeletePreferredCityUseCase
    private let isCityAlreadyAddedUseCase: IsCityAlreadyAddedUseCase
    private let getUIImageFromImageRepositoryUseCase: GetUIImageFromImageRepositoryUseCase
    private let searchCitiesUseCase: SearchCitiesUseCase
    private let addPreferredCityUseCase: AddPreferredCityUseCase

    private let actions: AddPreferredCityViewModelActions?
    
    init(addPreferredCityUseCase: AddPreferredCityUseCase, deletePreferredCityUseCase: DeletePreferredCityUseCase, searchCitiesUseCase: SearchCitiesUseCase, getUIImageFromImageRepositoryUseCase: GetUIImageFromImageRepositoryUseCase, isCityAlreadyAddedUseCase: IsCityAlreadyAddedUseCase, actions: AddPreferredCityViewModelActions? = nil) {
        self.addPreferredCityUseCase = addPreferredCityUseCase
        self.deletePreferredCityUseCase = deletePreferredCityUseCase
        self.searchCitiesUseCase = searchCitiesUseCase
        self.getUIImageFromImageRepositoryUseCase = getUIImageFromImageRepositoryUseCase
        self.isCityAlreadyAddedUseCase = isCityAlreadyAddedUseCase
        self.actions = actions
    }
    
    private func mapCellData() {
        self.cellDataSource.value = self.dataSource?.compactMap({
            DefaultSearchCityTableViewCellViewModel(deletePreferredCityUseCase: deletePreferredCityUseCase, getUIImageFromImageRepositoryUseCase: getUIImageFromImageRepositoryUseCase, addPreferredCityUseCase: addPreferredCityUseCase, isCityAlreadyAddedUseCase: isCityAlreadyAddedUseCase, city: $0, actions: nil)
        }) ?? []
    }
    
    private func searchCityByName(name: String) async {
        if (isLoading.value == false) {
            isLoading.value = true
            do {
                self.dataSource = try await searchCitiesUseCase.execute(name: name)
                self.isLoading.value = false
                if (self.dataSource?.isEmpty == true) {
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
