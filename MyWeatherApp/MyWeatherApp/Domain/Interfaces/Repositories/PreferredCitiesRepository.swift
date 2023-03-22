//
//  PreferredCitiesRepository.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 22/03/2023.
//

import Foundation

protocol PreferredCitiesRepository {
    func getPreferredCities() throws -> [String]
    func savePreferredCity(name: String) throws
}
