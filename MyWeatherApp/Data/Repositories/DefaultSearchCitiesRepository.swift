//
//  DefaultSearchCitiesRepository.swift
//  MyWeatherApp
//
//  Created by Enzo } on 24/03/2023.
//

import Foundation

final class DefaultSearchCitiesRepository {

    private let api: OpenWeatherAPI
    
    init(api: OpenWeatherAPI) {
        self.api = api
    }
}

extension DefaultSearchCitiesRepository: SearchCitiesRepository {

    func searchCitiesByName(name: String, completionHandler: @escaping (Result<SearchCitiesResult, SearchCitiesUseCaseError>) -> Void) {
        api.getCitiesByName(name: name, completionHandler: completionHandler)
    }
}
