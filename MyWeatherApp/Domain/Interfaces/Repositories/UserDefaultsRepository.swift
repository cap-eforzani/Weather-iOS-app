//
//  UserDefaultsRepository.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 03/04/2023.
//

import Foundation

protocol UserDefaultsRepository {
    func setShowLattitudeAndLongitudeSetting(value: Bool)
    func getShowLattitudeAndLongitudeSettingValue() -> Bool
}
