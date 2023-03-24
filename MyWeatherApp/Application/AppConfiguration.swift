//
//  AppConfiguration.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 22/03/2023.
//

import Foundation

final class AppConfiguration {
    lazy var apiKey: String = {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "ApiKey") as? String else {
            fatalError("ApiKey must not be empty in plist")
        }
        return apiKey
    }()
    
    lazy var apiBaseUrl: String = {
        guard let apiBaseUrl = Bundle.main.object(forInfoDictionaryKey: "ApiBaseUrl") as? String else {
            fatalError("ApiBaseUrl must not be empty in plist")
        }
        return apiBaseUrl
    }()
}
