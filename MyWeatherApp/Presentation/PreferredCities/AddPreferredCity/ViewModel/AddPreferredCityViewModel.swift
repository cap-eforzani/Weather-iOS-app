//
//  AddPreferredCityViewModel.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 23/03/2023.
//

import Foundation

struct AddPreferredCityViewModelActions {
    let navigateToPreviousView: () -> Void
    let navigateToSettings: () -> Void
}

protocol AddPreferredCityViewModelInput {
    func didTapSearchButton(searchValue: String) async -> Void
    func getNumberOfCities() -> Int
    func getHeightOfCell() -> CGFloat
    func didTapNavigationBarBackButton() -> Void
    func didTapNavigationBarSettingsButton() -> Void
    func didTapCityTableViewCellImageButton(index: Int) -> Void
    func showLastSearch() async -> Void
}

protocol AddPreferredCityViewModelOutput {
    var screenTitle: String { get }
    var noResults: Observable<Bool> { get }
    var isLoading: Observable<Bool> { get }
    var cellDataSource: Observable<[CityTableViewCellData]> { get }
}

typealias AddPreferredCityViewModel = AddPreferredCityViewModelInput & AddPreferredCityViewModelOutput

class DefaultAddPreferredCityViewModel : AddPreferredCityViewModel {
    
    let screenTitle = "Search for a City"
    
    var noResults: Observable<Bool> = Observable(false)
    var isLoading: Observable<Bool> = Observable(false)
    var cellDataSource: Observable<[CityTableViewCellData]> = Observable([])
    var dataSource: Cities?
    var oldSearch = ""

    private let deletePreferredCityUseCase: DeletePreferredCityUseCase
    private let isCityAlreadyAddedUseCase: IsCityAlreadyAddedUseCase
    private let getImageDataFromImageRepositoryUseCase: GetImageDataFromImageRepositoryUseCase
    private let searchCitiesUseCase: SearchCitiesUseCase
    private let addPreferredCityUseCase: AddPreferredCityUseCase
    private let getShowLattitudeAndLongitudeUseCase: GetShowLattitudeAndLongitudeUseCase

    private let actions: AddPreferredCityViewModelActions?

    init(addPreferredCityUseCase: AddPreferredCityUseCase, deletePreferredCityUseCase: DeletePreferredCityUseCase, searchCitiesUseCase: SearchCitiesUseCase, getImageDataFromImageRepositoryUseCase: GetImageDataFromImageRepositoryUseCase, isCityAlreadyAddedUseCase: IsCityAlreadyAddedUseCase, getShowLattitudeAndLongitudeUseCase: GetShowLattitudeAndLongitudeUseCase, actions: AddPreferredCityViewModelActions? = nil) {
        self.addPreferredCityUseCase = addPreferredCityUseCase
        self.deletePreferredCityUseCase = deletePreferredCityUseCase
        self.searchCitiesUseCase = searchCitiesUseCase
        self.getImageDataFromImageRepositoryUseCase = getImageDataFromImageRepositoryUseCase
        self.isCityAlreadyAddedUseCase = isCityAlreadyAddedUseCase
        self.getShowLattitudeAndLongitudeUseCase = getShowLattitudeAndLongitudeUseCase
        self.actions = actions
    }
    
    private func mapCellData() {
        let showLattitudeAndLongitude = getShowLattitudeAndLongitudeUseCase.execute()
        self.cellDataSource.value = self.dataSource?.compactMap({
            do {
                let isPreferred = try isCityAlreadyAddedUseCase.execute(city: $0)
                if (showLattitudeAndLongitude == true) {
                    return CityTableViewCellData(name: $0.name, country: $0.country, state: $0.state, lat: $0.lat, lon: $0.lon, imageData: getCellImageData(isPreferred: isPreferred))
                }
                return CityTableViewCellData(name: $0.name, country: $0.country, state: $0.state, lat: nil, lon: nil, imageData: getCellImageData(isPreferred: isPreferred))
            } catch {
                print("[ERROR] Cannot determine if " + $0.name + " is preferred")
            }
            return CityTableViewCellData(name: $0.name, country: $0.country, state: $0.state, lat: $0.lat, lon: $0.lon, imageData: getCellImageData(isPreferred: false))
        }) ?? []
    }
    
    private func searchCityByName(name: String) async {
        if (isLoading.value == false) {
            isLoading.value = true
            do {
                self.dataSource = try await searchCitiesUseCase.execute(name: name)
                self.mapCellData()
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
        }
    }
    
    private func setCityToPreferred(city: City) {
        do {
            try addPreferredCityUseCase.execute(city: city)
        } catch {
            print("[ERROR] City " + city.name + " not saved")
        }
    }
    
    private func deleteCityFromPreferred(city: City, index: Int) {
        do {
            try deletePreferredCityUseCase.execute(city: city)
        } catch {
            print("[ERROR] City " + city.name + " not deleted")
        }
    }
    
    private func getCellImageData(isPreferred: Bool) -> Data {
        do {
            if (isPreferred == true) {
                return try getImageDataFromImageRepositoryUseCase.execute(image: .preferred)
            } else {
                return try getImageDataFromImageRepositoryUseCase.execute(image: .notPreferred)
            }
        } catch {
            print("[ERROR] Unable to get image for city cells from preferred cities view")
        }
        return Data()
    }

}

extension DefaultAddPreferredCityViewModel {
    
    func didTapCityTableViewCellImageButton(index: Int) {
        if let cities: Cities = dataSource {
            let city = cities[index]
            do {
                let isPreferred = try isCityAlreadyAddedUseCase.execute(city: city)
                if (isPreferred == true) {
                    deleteCityFromPreferred(city: city, index: index)
                } else {
                    setCityToPreferred(city: city)
                }
                mapCellData()
            } catch {
                print("[ERROR] Cannot determine if " + city.name + " is preferred")
            }
        } else {
            print("[ERROR] City with index " + String(format: "%i", index) + " not found")
        }
    }
    
    func didTapNavigationBarBackButton() {
        actions?.navigateToPreviousView()
    }
    
    func didTapNavigationBarSettingsButton() {
        actions?.navigateToSettings()
    }
    
    func getHeightOfCell() -> CGFloat {
        if (getShowLattitudeAndLongitudeUseCase.execute() == true) {
            return 144
        }
        return 88
    }
    
    func didTapSearchButton(searchValue: String) async {
        if (searchValue.isEmpty == false) {
            oldSearch = searchValue
            await searchCityByName(name: searchValue)
        }
    }
    
    func showLastSearch() async {
        if (oldSearch.isEmpty == false) {
            await searchCityByName(name: oldSearch)
        }
    }
    
    func getNumberOfCities() -> Int {
        return self.dataSource?.count ?? 0
    }
}
