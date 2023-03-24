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
    func getTitleOfCityCell(city: SearchCitiesResultElement) -> String
    func didTapSearchButton(searchValue: String) -> Void
    func searchCityByName(name: String) -> Void
    func getNumberOfCities() -> Int
    func addCity(name: String) -> Void
}

protocol AddPreferredCityViewModelOutput {
    var noResults: Observable<Bool> { get }
    var isLoading: Observable<Bool> { get }
    var cityCells: Observable<[SearchCitiesResultElement]> { get }
}

typealias AddPreferredCityViewModel = AddPreferredCityViewModelInput & AddPreferredCityViewModelOutput

class DefaultAddPreferredCityViewModel : AddPreferredCityViewModel {
    
    var noResults: Observable<Bool> = Observable(false)
    var isLoading: Observable<Bool> = Observable(false)
    var cityCells: Observable<[SearchCitiesResultElement]> = Observable([])
    var cities: SearchCitiesResult?
    
    private let searchCitiesUseCase: SearchCitiesUseCase
    private let addPreferredCityUseCase: AddPreferredCityUseCase
    private let actions: AddPreferredCityViewModelActions?
    
    init(addPreferredCityUseCase: AddPreferredCityUseCase, searchCitiesUseCase: SearchCitiesUseCase, actions: AddPreferredCityViewModelActions? = nil) {
        self.addPreferredCityUseCase = addPreferredCityUseCase
        self.searchCitiesUseCase = searchCitiesUseCase
        self.actions = actions
    }
    
    private func mapCellData() {
        self.cityCells.value = self.cities ?? []
    }
}

extension DefaultAddPreferredCityViewModel {
    
    func addCity(name: String) {
        // TODO save selected city
    }
    
    func getTitleOfCityCell(city: SearchCitiesResultElement) -> String {
        return city.name + ", " + city.country + ", " + city.state
    }
    
    func didTapSearchButton(searchValue: String) {
        let trimmedString = searchValue.trimmingCharacters(in: .whitespaces)
        if (trimmedString.isEmpty == false) {
            searchCityByName(name: trimmedString)
        }
    }
    
    func searchCityByName(name: String) {
        if (isLoading.value == false) {
            isLoading.value = true
            searchCitiesUseCase.execute(name: name) { result in
                switch result {
                case .success(let result):
                    self.cities = result
                    self.mapCellData()
                    self.isLoading.value = false
                    if (result.isEmpty) {
                        self.noResults.value = true
                    } else {
                        self.noResults.value = false
                    }
                case .failure(_):
                    self.cities = []
                    self.mapCellData()
                    self.isLoading.value = false
                    self.noResults.value = true
                }
            }
        }
    }
    
    func getNumberOfCities() -> Int {
        return self.cities?.count ?? 0
    }
}
