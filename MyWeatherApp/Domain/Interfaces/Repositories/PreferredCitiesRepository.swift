//
//  PreferredCitiesRepository.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 22/03/2023.
//

import Foundation

protocol PreferredCitiesRepository {
    func getPreferredCities() throws -> Cities
    func savePreferredCity(city: City) throws
    func isCityAlreadyAddedToPreferred(city: City) throws -> Bool
}
