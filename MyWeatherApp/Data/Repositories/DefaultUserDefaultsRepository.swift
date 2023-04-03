//
//  DefaultUserDefaultsRepository.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 03/04/2023.
//

import Foundation

final class DefaultUserDefaultsRepository : UserDefaultsRepository {

    func setShowLattitudeAndLongitudeSetting(value: Bool) {
        UserDefaults.standard.set(value, forKey: "showLattitudeAndLongitude")
    }
    
    func getShowLattitudeAndLongitudeSettingValue() -> Bool {
        return UserDefaults.standard.bool(forKey: "showLattitudeAndLongitude")
    }
}
