//
//  AppContainer.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 23/03/2023.
//

import Foundation

final class AppContainer {
    
    lazy var appConfiguration = AppConfiguration()
    
    lazy var openWeatherAPI = OpenWeatherAPI(apiKey: appConfiguration.apiKey, apiBaseUrl: appConfiguration.apiBaseUrl)
    
    func makePreferredListContainer() ->  PreferredCitiesContainer {
        let dependencies = PreferredCitiesContainer.Dependencies(api: openWeatherAPI)
        return PreferredCitiesContainer(dependencies: dependencies)
    }
}
