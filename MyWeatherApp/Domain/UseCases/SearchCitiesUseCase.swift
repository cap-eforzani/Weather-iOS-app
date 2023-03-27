//
//  SearchCitiesUseCase.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 24/03/2023.
//

import Foundation

enum SearchCitiesUseCaseError: Error {
    case apiUrlError
    case cannotParseData
}

protocol SearchCitiesUseCase {
    func execute(name: String) async throws -> Cities
}

final class DefaultSearchCitiesUseCase : SearchCitiesUseCase {

    private let searchCitiesRepository: SearchCitiesRepository
    
    init(searchCitiesRepository: SearchCitiesRepository) {
        self.searchCitiesRepository = searchCitiesRepository
    }
    
    func execute(name: String) async throws -> Cities {
        return try await searchCitiesRepository.searchCitiesByName(name: name)
    }
}
