//
//  DefaultSearchCityTableViewCellViewModel.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 30/03/2023.
//

import Foundation
import UIKit

struct SearchCityTableViewCellViewModelActions {
}

protocol SearchCityTableViewCellViewModel {
    func setCityToPreferred() -> Void
    func didTapImageButton() -> Void
    func setImageToImageButton() -> Void
}

class DefaultSearchCityTableViewCellViewModel : DefaultCityTableViewCellViewModel, SearchCityTableViewCellViewModel {
    
    let isCityAlreadyAddedUseCase: IsCityAlreadyAddedUseCase
    let addPreferredCityUseCase: AddPreferredCityUseCase
    private var actions: SearchCityTableViewCellViewModelActions?
    
    init(deletePreferredCityUseCase: DeletePreferredCityUseCase, getUIImageFromImageRepositoryUseCase: GetUIImageFromImageRepositoryUseCase, addPreferredCityUseCase: AddPreferredCityUseCase, isCityAlreadyAddedUseCase: IsCityAlreadyAddedUseCase, city: City, actions: SearchCityTableViewCellViewModelActions? = nil) {
        self.isCityAlreadyAddedUseCase = isCityAlreadyAddedUseCase
        self.addPreferredCityUseCase = addPreferredCityUseCase
        self.actions = actions
        super.init(deletePreferredCityUseCase: deletePreferredCityUseCase, getUIImageFromImageRepositoryUseCase: getUIImageFromImageRepositoryUseCase, city: city)
    }
    
    func setCityToPreferred() {
        do {
            try addPreferredCityUseCase.execute(city: self.city)
        } catch {
            print("[ERROR] City " + self.city.name + " not saved")
        }
    }
    
    override func didTapImageButton() {
        do {
            isPreferred.value = try isCityAlreadyAddedUseCase.execute(city: self.city)
            if (isPreferred.value == true) {
                deleteCityFromPreferred()
            } else {
                setCityToPreferred()
            }
            setImageToImageButton()
        } catch {
            print("[ERROR] Cannot determine if " + self.city.name + " is preferred")
        }
    }
    
    override func setImageToImageButton() {
        do {
            isPreferred.value = try isCityAlreadyAddedUseCase.execute(city: self.city)
            if (isPreferred.value == true) {
                imageForImageButton.value = try getUIImageFromImageRepositoryUseCase.execute(image: ImageAvailableFromImageRepository.preferred)
            } else {
                imageForImageButton.value = try getUIImageFromImageRepositoryUseCase.execute(image: ImageAvailableFromImageRepository.notPreferred)
            }
        } catch {
            imageForImageButton.value = UIImage()
        }
    }
    
}
