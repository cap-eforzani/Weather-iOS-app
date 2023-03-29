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
    // TODO throws exception when error
    func setCityToPreferred() -> Void
}

protocol CityTableViewCellViewModelOutput {
    var isPreferredImage: Observable<UIImage> { get }
}

typealias CityTableViewCellViewModel = CityTableViewCellViewModelInput & CityTableViewCellViewModelOutput

class DefaultCityTableViewCellViewModel : CityTableViewCellViewModel {

    var isPreferredImage: Observable<UIImage> = Observable(UIImage())
    
    private let city: City
    
    private let isCityAlreadyAddedUseCase: IsCityAlreadyAddedUseCase
    private let addPreferredCityUseCase: AddPreferredCityUseCase
    private let getIsPreferredImageUseCase: GetIsPreferredImageUseCase
    private let actions: CityTableViewCellViewModelActions?
    
    init(isCityAlreadyAddedUseCase: IsCityAlreadyAddedUseCase, addPreferredCityUseCase: AddPreferredCityUseCase, getIsPreferredImageUseCase: GetIsPreferredImageUseCase, actions: CityTableViewCellViewModelActions? = nil, city: City) {
        self.city = city
        self.isCityAlreadyAddedUseCase = isCityAlreadyAddedUseCase
        self.addPreferredCityUseCase = addPreferredCityUseCase
        self.getIsPreferredImageUseCase = getIsPreferredImageUseCase
        self.actions = actions
    }
}

extension DefaultCityTableViewCellViewModel {

    func setCityToPreferred() {
        do {
            try addPreferredCityUseCase.execute(city: self.city)
        } catch {
            print("City not saved")
        }
    }
    
    func getIsPreferredImage() -> Void {
        do {
            let isCityAddedToPreferred = try isCityAlreadyAddedUseCase.execute(city: self.city)
            isPreferredImage.value = try getIsPreferredImageUseCase.execute(isPreferred: isCityAddedToPreferred)
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
