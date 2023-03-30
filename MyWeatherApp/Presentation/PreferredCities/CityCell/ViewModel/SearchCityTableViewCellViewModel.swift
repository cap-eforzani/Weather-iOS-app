//
//  SearchCityTableViewCellViewModel.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 30/03/2023.
//

import Foundation
import UIKit

struct SearchCityTableViewCellViewModelActions {
}

class DefaultSearchCityTableViewCellViewModel : DefaultCityTableViewCellViewModel {
    
    private var actions: SearchCityTableViewCellViewModelActions?
    
    init(deletePreferredCityUseCase: DeletePreferredCityUseCase, getUIImageFromImageRepositoryUseCase: GetUIImageFromImageRepositoryUseCase, addPreferredCityUseCase: AddPreferredCityUseCase, isCityAlreadyAddedUseCase: IsCityAlreadyAddedUseCase, city: City, actions: SearchCityTableViewCellViewModelActions? = nil) {
        self.actions = actions
        super.init(isCityAlreadyAddedUseCase: isCityAlreadyAddedUseCase, deletePreferredCityUseCase: deletePreferredCityUseCase, addPreferredCityUseCase: addPreferredCityUseCase, getUIImageFromImageRepositoryUseCase: getUIImageFromImageRepositoryUseCase, city: city)
    }
    
    override func didTapImageButton() {
        do {
            if let isCityAlreadyAddedUseCase = self.isCityAlreadyAddedUseCase {
                isPreferred.value = try isCityAlreadyAddedUseCase.execute(city: self.city)
                if (isPreferred.value == true) {
                    deleteCityFromPreferred()
                } else {
                    setCityToPreferred()
                }
                setImageToImageButton()
            }
        } catch {
            print("[ERROR] Cannot determine if " + self.city.name + " is preferred")
        }
    }
    
    override func setImageToImageButton() {
        do {
            if let isCityAlreadyAddedUseCase = self.isCityAlreadyAddedUseCase {
                isPreferred.value = try isCityAlreadyAddedUseCase.execute(city: self.city)
                if (isPreferred.value == true) {
                    imageForImageButton.value = try getUIImageFromImageRepositoryUseCase.execute(image: ImageAvailableFromImageRepository.preferred)
                } else {
                    imageForImageButton.value = try getUIImageFromImageRepositoryUseCase.execute(image: ImageAvailableFromImageRepository.notPreferred)
                }
            }
        } catch {
            imageForImageButton.value = UIImage()
        }
    }
    
}
