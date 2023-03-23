//
//  AppContainer.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 23/03/2023.
//

import Foundation

final class AppContainer {
    
    lazy var appConfiguration = AppConfiguration()
    
    func makePreferredListContainer() ->  PreferredCitiesContainer {
        let dependencies = PreferredCitiesContainer.Dependencies(test: "Test")
        return PreferredCitiesContainer(dependencies: dependencies)
    }
}
