//
//  DefaultPreferredCitiesRepository.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 22/03/2023.
//

import Foundation

final class DefaultPreferredCitiesRepository {
    
    var fileUrl: URL = {
        let docDir = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        return docDir.appendingPathExtension("MyPreferredCities.plist")
    }()
    
    func getPreferredCitiesFromRepository() throws -> [String] {
        let contentsOfFileUrl = try Data(contentsOf: self.fileUrl)
        return try PropertyListDecoder().decode(Array<String>.self, from: contentsOfFileUrl)
    }
    
    func savePreferredCityToRepository(name: String) throws {
        let preferredCities = try getPreferredCitiesFromRepository()
        let newContents = try PropertyListEncoder().encode(preferredCities)
        try newContents.write(to: self.fileUrl, options: [.atomic])
    }
    
}

extension DefaultPreferredCitiesRepository: PreferredCitiesRepository {

    func getPreferredCities() throws -> [String] {
        return try getPreferredCitiesFromRepository()
    }
    
    func savePreferredCity(name: String) throws {
        return try savePreferredCityToRepository(name: name)
    }
    
    
}
