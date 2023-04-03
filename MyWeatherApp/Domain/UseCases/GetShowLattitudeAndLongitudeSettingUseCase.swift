//
//  GetShowLattitudeAndLongitudeSettingUseCase.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 03/04/2023.
//

import Foundation

protocol GetShowLattitudeAndLongitudeUseCase {
    func execute() -> Bool
}

final class DefaultGetShowLattitudeAndLongitudeUseCase : GetShowLattitudeAndLongitudeUseCase {

    private let userDefaultsRepository: UserDefaultsRepository
    
    init(userDefaultsRepository: UserDefaultsRepository) {
        self.userDefaultsRepository = userDefaultsRepository
    }
    
    func execute() -> Bool {
        return userDefaultsRepository.getShowLattitudeAndLongitudeSettingValue()
    }
}
