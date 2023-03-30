//
//  GetPreferredCitiesUseCase.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 23/03/2023.
//

import Foundation

enum GetPreferredCitiesUseCaseError: Error {
    case cityNameNotFound
    case cityLatNotFound
    case cityLonNotFound
    case cityCountryNotFound
    case cityStateNotFound
    case cityIsPreferredNotFound
}

protocol GetPreferredCitiesUseCase {
    func execute() throws -> Cities
}

final class DefaultGetPreferredCityUseCase : GetPreferredCitiesUseCase {
    
    private let preferredCitiesRepository: PreferredCitiesRepository
    
    init(preferredCitiesRepository: PreferredCitiesRepository) {
        self.preferredCitiesRepository = preferredCitiesRepository
    }
    
    func execute() throws -> Cities {
        return try preferredCitiesRepository.getPreferredCities()
    }
    
}
