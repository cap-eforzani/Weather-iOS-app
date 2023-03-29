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
    func execute() throws -> Int
}

final class DefaultGetPreferredCityUseCase : GetPreferredCitiesUseCase {
    
    private let preferredCitiesRepository: PreferredCitiesRepository
    
    init(preferredCitiesRepository: PreferredCitiesRepository) {
        self.preferredCitiesRepository = preferredCitiesRepository
    }
    
    func execute() throws -> Int {
        let preferredCities = try preferredCitiesRepository.getPreferredCities()
        print("PREFERRED CITIES from GetUseCase")
        print(preferredCities)
        return preferredCities.count
    }
    
}
