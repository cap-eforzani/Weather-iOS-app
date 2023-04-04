//
//  PreferredCitiesListViewModel.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 22/03/2023.
//

import Foundation

struct PreferredCitiesListViewModelActions {
    let navigateToSettings: () -> Void
    let navigateToSearchCity: () -> Void
}

protocol PreferredCitiesListViewModelInput {
    func getHeightOfCell() -> CGFloat
    func getPreferredCities() -> Void
    func getNumberOfPreferredCities() -> Int
    func didTapFloatingButton() -> Void
    func didTapNavigationBarSettingsButton() -> Void
    func didTapCityCellImageButton(index: Int) -> Void
}

protocol PreferredCitiesListViewModelOutput {
    var screenTitle: String { get }
    var noResults: Observable<Bool> { get }
    var cellDataSource: Observable<[CityTableViewCellData]> { get }
    var isLoading: Observable<Bool> { get }
}

typealias PreferredCitiesListViewModel = PreferredCitiesListViewModelInput & PreferredCitiesListViewModelOutput

class DefaultPreferredCitiesListViewModel : PreferredCitiesListViewModel {

    var noResults: Observable<Bool> = Observable(false)
    var cellDataSource: Observable<[CityTableViewCellData]> = Observable([])
    var isLoading: Observable<Bool> = Observable(false)
    var dataSource: Cities?
    
    let screenTitle: String = "My Preferred Cities"
    
    private let getShowLattitudeAndLongitudeUseCase: GetShowLattitudeAndLongitudeUseCase
    private let getPreferredCitiesUseCase: GetPreferredCitiesUseCase
    private let deletePreferredCityUseCase: DeletePreferredCityUseCase
    private let isCityAlreadyAddedUseCase: IsCityAlreadyAddedUseCase
    private let getImageDataFromImageRepositoryUseCase: GetImageDataFromImageRepositoryUseCase
    private let addPreferredCityUseCase: AddPreferredCityUseCase

    private let actions: PreferredCitiesListViewModelActions?
        
    init(getPreferredCitiesUseCase: GetPreferredCitiesUseCase, isCityAlreadyAddedUseCase: IsCityAlreadyAddedUseCase, getImageDataFromImageRepositoryUseCase: GetImageDataFromImageRepositoryUseCase, addPreferredCityUseCase: AddPreferredCityUseCase, deletePreferredCityUseCase: DeletePreferredCityUseCase, getShowLattitudeAndLongitudeUseCase: GetShowLattitudeAndLongitudeUseCase, actions: PreferredCitiesListViewModelActions? = nil) {
        self.getPreferredCitiesUseCase = getPreferredCitiesUseCase
        self.isCityAlreadyAddedUseCase = isCityAlreadyAddedUseCase
        self.getImageDataFromImageRepositoryUseCase = getImageDataFromImageRepositoryUseCase
        self.addPreferredCityUseCase = addPreferredCityUseCase
        self.deletePreferredCityUseCase = deletePreferredCityUseCase
        self.getShowLattitudeAndLongitudeUseCase = getShowLattitudeAndLongitudeUseCase
        self.actions = actions
    }
    
    private func getCellImageData() -> Data {
        do {
            return try getImageDataFromImageRepositoryUseCase.execute(image: .delete)
        } catch {
            print("[ERROR] Unable to get image for city cells from preferred cities view")
        }
        return Data()
    }
    
    private func mapCellData() {
        let showLattitudeAndLongitude = getShowLattitudeAndLongitudeUseCase.execute()
        self.cellDataSource.value = self.dataSource?.compactMap({
            CityTableViewCellData(name: $0.name, country: $0.country, state: $0.state, lat: showLattitudeAndLongitude == true ? $0.lat : nil, lon: showLattitudeAndLongitude == true ? $0.lon : nil, imageData: getCellImageData())
        }) ?? []
    }
    
    private func deleteCityFromPreferred(city: City, index: Int) {
        do {
            try deletePreferredCityUseCase.execute(city: city)
            dataSource?.remove(at: index)
            mapCellData()
        } catch {
            print("[ERROR] City " + city.name + " not deleted")
        }
    }
}

extension DefaultPreferredCitiesListViewModel {

    func getHeightOfCell() -> CGFloat {
        if (getShowLattitudeAndLongitudeUseCase.execute() == true) {
            return 144
        }
        return 88
    }
    
    func didTapNavigationBarSettingsButton() {
        actions?.navigateToSettings()
    }
    
    func didTapFloatingButton() {
        actions?.navigateToSearchCity()
    }
    
    func didTapCityCellImageButton(index: Int) {
        if let cities: Cities = dataSource {
            let cellData = cities[index]
            deleteCityFromPreferred(city: cellData, index: index)
        } else {
            print("[ERROR] City with index " + String(format: "%i", index) + " not found")
        }
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
