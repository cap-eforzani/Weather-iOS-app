//
//  CityTableViewCellViewModel.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 25/03/2023.
//

import Foundation

struct CityTableViewCellViewModel : Equatable {
    let cityName: String
    let country: String
    let state: String
}

extension CityTableViewCellViewModel {
    init(city: City) {
        self.cityName = city.name
        self.country = city.country
        self.state = city.state
    }
    
    func getCountryAndStateText() -> String {
        return self.country + ", " + self.state
    }
}
