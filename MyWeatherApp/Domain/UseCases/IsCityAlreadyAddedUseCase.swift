//
//  IsCityAlreadyAddedUseCase.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 29/03/2023.
//

import Foundation

enum IsCityAlreadyAddedUseCaseError: Error {
    case getPreferredCitiesUseCaseError
}

protocol IsCityAlreadyAddedUseCase {
    func execute(city: City) throws -> Bool
}

final class DefaultIsCityAlreadyAddedUseCase : IsCityAlreadyAddedUseCase {

    private let preferredCitiesRepository: PreferredCitiesRepository
    
    init(preferredCitiesRepository: PreferredCitiesRepository) {
        self.preferredCitiesRepository = preferredCitiesRepository
    }
    
    func execute(city: City) throws -> Bool {
        return try preferredCitiesRepository.isCityAlreadyAddedToPreferred(city: city)
    }
}
