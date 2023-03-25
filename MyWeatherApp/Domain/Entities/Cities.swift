//
//  SearchCitiesResult.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 24/03/2023.
//

import Foundation

struct City: Codable {
    let name: String
    let lat, lon: Double
    let country, state: String
}

typealias Cities = [City]
