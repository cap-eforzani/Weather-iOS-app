//
//  PreferredCitiesTableViewCellViewModel.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 30/03/2023.
//

import Foundation
import UIKit

struct PreferredCitiesTableViewCellViewModelActions {
    let getPreferredCities: () -> Void
}

protocol PreferredCitiesTableViewCellViewModel {
    func didTapImageButton() -> Void
    func setImageToImageButton() -> Void
}

class DefaultPreferredCitiesTableViewCellViewModel : DefaultCityTableViewCellViewModel, PreferredCitiesTableViewCellViewModel {
    
    private var actions: PreferredCitiesTableViewCellViewModelActions
    
    init(deletePreferredCityUseCase: DeletePreferredCityUseCase, getUIImageFromImageRepositoryUseCase: GetUIImageFromImageRepositoryUseCase, city: City, actions: PreferredCitiesTableViewCellViewModelActions) {
        self.actions = actions
        super.init(deletePreferredCityUseCase: deletePreferredCityUseCase, getUIImageFromImageRepositoryUseCase: getUIImageFromImageRepositoryUseCase, city: city)
    }
    
    override func didTapImageButton() {
        deleteCityFromPreferred()
        actions.getPreferredCities()
    }
    
    override func setImageToImageButton() {
        do {
            imageForImageButton.value = try getUIImageFromImageRepositoryUseCase.execute(image: ImageAvailableFromImageRepository.delete)
        } catch {
            imageForImageButton.value = UIImage()
        }
    }
}
