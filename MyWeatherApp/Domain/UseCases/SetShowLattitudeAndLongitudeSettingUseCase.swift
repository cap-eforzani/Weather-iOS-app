//
//  SetShowLattitudeAndLongitudeSettingUseCase.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 03/04/2023.
//

import Foundation

protocol SetShowLattitudeAndLongitudeUseCase {
    func execute(value: Bool)
}

final class DefaultSetShowLattitudeAndLongitudeUseCase : SetShowLattitudeAndLongitudeUseCase {

    private let userDefaultsRepository: UserDefaultsRepository
    
    init(userDefaultsRepository: UserDefaultsRepository) {
        self.userDefaultsRepository = userDefaultsRepository
    }
    
    func execute(value: Bool) {
        return userDefaultsRepository.setShowLattitudeAndLongitudeSetting(value: value)
    }
}
