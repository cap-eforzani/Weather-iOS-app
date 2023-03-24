//
//  AddPreferredCityUseCase.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 23/03/2023.
//

import Foundation

protocol AddPreferredCityUseCase {
    func execute(name: String) throws -> Void
}

final class DefaultAddPreferredCityUseCase : AddPreferredCityUseCase {
    
    private let preferredCitiesRepository: PreferredCitiesRepository
    
    init(preferredCitiesRepository: PreferredCitiesRepository) {
        self.preferredCitiesRepository = preferredCitiesRepository
    }
    
    func execute(name: String) throws {
        try preferredCitiesRepository.savePreferredCity(name: name)
    }
    
}
