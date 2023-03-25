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
    func execute(name: String, completionHandler: @escaping (_ result: Result<Cities, SearchCitiesUseCaseError>) -> Void)
}

final class DefaultSearchCitiesUseCase : SearchCitiesUseCase {

    private let searchCitiesRepository: SearchCitiesRepository
    
    init(searchCitiesRepository: SearchCitiesRepository) {
        self.searchCitiesRepository = searchCitiesRepository
    }
    
    func execute(name: String, completionHandler: @escaping (Result<Cities, SearchCitiesUseCaseError>) -> Void) {
        return searchCitiesRepository.searchCitiesByName(name: name, completionHandler: completionHandler)
    }
}
