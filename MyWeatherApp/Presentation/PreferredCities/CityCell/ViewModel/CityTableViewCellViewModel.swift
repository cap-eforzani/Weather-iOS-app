//
//  CityTableViewCellViewModel.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 25/03/2023.
//

import Foundation
import UIKit

struct CityTableViewCellViewModelActions {
}

protocol CityTableViewCellViewModelInput {
    func getIsPreferredImage() -> Void
    func getCountryAndStateText() -> String
    func getLatText() -> String
    func getLonText() -> String
    func getCityName() -> String
    func setCityToPreferred() -> Void
    func deleteCityFromPreferred() -> Void
    func didTapPreferredButton() -> Void
}

protocol CityTableViewCellViewModelOutput {
    var isPreferred: Observable<Bool> { get }
    var isPreferredImage: Observable<UIImage> { get }
}

typealias CityTableViewCellViewModel = CityTableViewCellViewModelInput & CityTableViewCellViewModelOutput

class DefaultCityTableViewCellViewModel : CityTableViewCellViewModel {

    var isPreferred: Observable<Bool> = Observable(false)
    var isPreferredImage: Observable<UIImage> = Observable(UIImage())
    
    private let city: City
    
    private let isCityAlreadyAddedUseCase: IsCityAlreadyAddedUseCase
    private let deletePreferredCityUseCase: DeletePreferredCityUseCase
    private let addPreferredCityUseCase: AddPreferredCityUseCase
    private let getIsPreferredImageUseCase: GetIsPreferredImageUseCase
    private let actions: CityTableViewCellViewModelActions?
    
    init(isCityAlreadyAddedUseCase: IsCityAlreadyAddedUseCase, deletePreferredCityUseCase: DeletePreferredCityUseCase, addPreferredCityUseCase: AddPreferredCityUseCase, getIsPreferredImageUseCase: GetIsPreferredImageUseCase, actions: CityTableViewCellViewModelActions? = nil, city: City) {
        self.city = city
        self.isCityAlreadyAddedUseCase = isCityAlreadyAddedUseCase
        self.deletePreferredCityUseCase = deletePreferredCityUseCase
        self.addPreferredCityUseCase = addPreferredCityUseCase
        self.getIsPreferredImageUseCase = getIsPreferredImageUseCase
        self.actions = actions
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
    
    func setCityToPreferred() {
        do {
            try addPreferredCityUseCase.execute(city: self.city)
        } catch {
            print("[ERROR] City " + self.city.name + " not saved")
        }
    }
    
    func didTapPreferredButton() {
        do {
            isPreferred.value = try isCityAlreadyAddedUseCase.execute(city: self.city)
            if (isPreferred.value == true) {
                deleteCityFromPreferred()
            } else {
                setCityToPreferred()
            }
            getIsPreferredImage()
        } catch {
            print("[ERROR] Cannot determine if " + self.city.name + " is preferred")
        }
    }
    
    func getIsPreferredImage() {
        do {
            isPreferred.value = try isCityAlreadyAddedUseCase.execute(city: self.city)
            isPreferredImage.value = try getIsPreferredImageUseCase.execute(isPreferred: isPreferred.value)
        } catch {
            isPreferredImage.value = UIImage()
        }
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
