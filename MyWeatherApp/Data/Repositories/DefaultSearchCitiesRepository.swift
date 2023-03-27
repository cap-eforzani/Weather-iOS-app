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

    func searchCitiesByName(name: String) async throws -> Cities {
        let trimmedName = name.trimmingCharacters(in: .whitespaces)
        if (trimmedName.isEmpty == false) {
            let result = await withCheckedContinuation { continuation in
                api.getCitiesByName(name: trimmedName) { cities in
                    continuation.resume(returning: cities)
                }
            }
            let cities = try result.get()
            return removeSameCities(cities: cities)
        }
        return []
    }
    
    private func removeSameCities(cities: Cities) -> Cities {
        var alreadyThere = Set<City>()
        let uniqueCities = cities.compactMap { (city) -> City? in
            guard !alreadyThere.contains(city) else { return nil }
            alreadyThere.insert(city)
            return city
        }
        return uniqueCities
    }
}
