//
//  SearchCitiesRepository.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 24/03/2023.
//

import Foundation

protocol SearchCitiesRepository {
    func searchCitiesByName(name: String) async throws -> Cities
}
