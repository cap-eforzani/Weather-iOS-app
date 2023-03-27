//
//  AddPreferredCityViewModel.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 23/03/2023.
//

import Foundation

struct AddPreferredCityViewModelActions {
    let showPreferredCities: () -> Void
}

protocol AddPreferredCityViewModelInput {
    func didTapSearchButton(searchValue: String) async -> Void
    func getNumberOfCities() -> Int
    func getHeightOfCell() -> CGFloat
    func addCity(name: String) -> Void
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
    
    private let searchCitiesUseCase: SearchCitiesUseCase
    private let addPreferredCityUseCase: AddPreferredCityUseCase
    private let actions: AddPreferredCityViewModelActions?
    
    init(addPreferredCityUseCase: AddPreferredCityUseCase, searchCitiesUseCase: SearchCitiesUseCase, actions: AddPreferredCityViewModelActions? = nil) {
        self.addPreferredCityUseCase = addPreferredCityUseCase
        self.searchCitiesUseCase = searchCitiesUseCase
        self.actions = actions
    }
    
    private func mapCellData() {
        self.cellDataSource.value = self.dataSource?.compactMap({
            CityTableViewCellViewModel(city: $0)
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
    
    func addCity(name: String) {
        // TODO save selected city
    }
    
    func getHeightOfCell() -> CGFloat {
        80
    }
    
    func didTapSearchButton(searchValue: String) async {
        await searchCityByName(name: searchValue)
    }
    
    func getNumberOfCities() -> Int {
        return self.dataSource?.count ?? 0
    }
}
