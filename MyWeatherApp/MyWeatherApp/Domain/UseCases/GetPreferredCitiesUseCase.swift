//
//  GetPreferredCitiesUseCase.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 23/03/2023.
//

import Foundation

protocol GetPreferredCityUseCase {
    func execute() throws -> Int
}

final class DefaultGetPreferredCityUseCase : GetPreferredCityUseCase {
    
    private let preferredCitiesRepository: PreferredCitiesRepository
    
    init(preferredCitiesRepository: PreferredCitiesRepository) {
        self.preferredCitiesRepository = preferredCitiesRepository
    }
    
    func execute() throws -> Int {
        let preferredCities = try preferredCitiesRepository.getPreferredCities()
        return preferredCities.count
    }
    
}
