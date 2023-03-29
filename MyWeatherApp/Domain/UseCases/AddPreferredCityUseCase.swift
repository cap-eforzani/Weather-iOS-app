//
//  AddPreferredCityUseCase.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 23/03/2023.
//

import Foundation

enum AddPreferredCityUseCaseError: Error {
    case coreDataSavingFailed
}

protocol AddPreferredCityUseCase {
    func execute(city: City) throws -> Void
}

final class DefaultAddPreferredCityUseCase : AddPreferredCityUseCase {
    
    private let preferredCitiesRepository: PreferredCitiesRepository
    
    init(preferredCitiesRepository: PreferredCitiesRepository) {
        self.preferredCitiesRepository = preferredCitiesRepository
    }
    
    func execute(city: City) throws {
        try preferredCitiesRepository.savePreferredCity(city: city)
    }
    
}
