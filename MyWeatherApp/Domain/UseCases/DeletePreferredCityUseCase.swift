//
//  DeletePreferredCityUseCase.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 29/03/2023.
//

import Foundation

enum DeletePreferredCityUseCaseError: Error {
    case coreDataSavingFailed
}

protocol DeletePreferredCityUseCase {
    func execute(city: City) throws
}

final class DefaultDeletePreferredCityUseCase : DeletePreferredCityUseCase {

    private let preferredCitiesRepository: PreferredCitiesRepository
    
    init(preferredCitiesRepository: PreferredCitiesRepository) {
        self.preferredCitiesRepository = preferredCitiesRepository
    }
    
    func execute(city: City) throws {
        return try preferredCitiesRepository.removePreferredCity(city: city)
    }
}
