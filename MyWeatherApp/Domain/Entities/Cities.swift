//
//  SearchCitiesResult.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 24/03/2023.
//

import Foundation

struct City: Codable, Hashable, Equatable {
    let name: String
    let lat, lon: Double
    let country, state: String
    
    func isEquals(to city: City) -> Bool {
        if (self.name == city.name && self.lat == city.lat && self.lon == city.lon && self.country == city.country && self.state == city.state) {
            return true
        }
        return false
    }
}

typealias Cities = [City]
