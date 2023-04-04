//
//  CityTableViewCellViewModel.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 25/03/2023.
//

import Foundation

protocol CityTableViewCellViewModelInput {
    func setImageToImageButton() -> Void
    func getCountryAndStateText() -> String
    func getLatText() -> String
    func getLonText() -> String
    func getCityName() -> String
    func deleteCityFromPreferred() -> Void
    func didTapImageButton() -> Void
}

protocol CityTableViewCellViewModelOutput {
    var isPreferred: Observable<Bool> { get }
    var imageForImageButton: Observable<Data?> { get }
}

typealias CityTableViewCellViewModel = CityTableViewCellViewModelInput & CityTableViewCellViewModelOutput

class DefaultCityTableViewCellViewModel : CityTableViewCellViewModel {

    var isPreferred: Observable<Bool> = Observable(false)
    var imageForImageButton: Observable<Data?> = Observable(nil)
    
    let city: City
    
    let deletePreferredCityUseCase: DeletePreferredCityUseCase
    let getImageDataFromImageRepositoryUseCase: GetImageDataFromImageRepositoryUseCase
    
    init(deletePreferredCityUseCase: DeletePreferredCityUseCase, getImageDataFromImageRepositoryUseCase: GetImageDataFromImageRepositoryUseCase, city: City) {
        self.city = city
        self.deletePreferredCityUseCase = deletePreferredCityUseCase
        self.getImageDataFromImageRepositoryUseCase = getImageDataFromImageRepositoryUseCase
    }
}

extension DefaultCityTableViewCellViewModel {

    func deleteCityFromPreferred() {
        do {
            try deletePreferredCityUseCase.execute(city: self.city)
        } catch {
            print("[ERROR] City " + self.city.name + " not deleted")
        }
    }
    
    @objc func didTapImageButton() {
        print("CityTableViewCellViewModel: didTapImageButton() not overriden")
    }
    
    @objc func setImageToImageButton() {
        print("CityTableViewCellViewModel: setImageToImageButton() not overriden")
    }
    
    func getCountryAndStateText() -> String {
        return self.city.country + ", " + self.city.state
    }
    
    func getCityName() -> String {
        return self.city.name
    }
    
    func getLatText() -> String {
        let latValue: String = String(format: "%f", self.city.lat)
        return "Latitude: " + latValue
    }
    
    func getLonText() -> String {
        let lonValue: String = String(format: "%f", self.city.lon)
        return "Longitude: " + lonValue
    }
}
