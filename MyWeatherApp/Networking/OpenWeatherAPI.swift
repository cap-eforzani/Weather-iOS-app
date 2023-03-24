//
//  OpenWeatherAPI.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 24/03/2023.
//

import Foundation

class OpenWeatherAPI {
    
    private let apiKey: String
    private let apiBaseUrl: String
    
    init(apiKey: String, apiBaseUrl: String) {
        self.apiKey = apiKey
        self.apiBaseUrl = apiBaseUrl
    }
    
    func getCitiesByName(name: String, completionHandler: @escaping (_ result: Result<SearchCitiesResult, SearchCitiesUseCaseError>) -> Void) {
        let urlString = apiBaseUrl + "/geo/1.0/direct?q=" + name + "&limit=10&appid=" + apiKey
        
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.apiUrlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, error in
            if error == nil,
                let data = dataResponse,
                let resultData = try? JSONDecoder().decode(SearchCitiesResult.self, from: data) {
                    completionHandler(.success(resultData))
                } else {
                    completionHandler(.failure(.cannotParseData))
                }
        }.resume()
        
    }
}
