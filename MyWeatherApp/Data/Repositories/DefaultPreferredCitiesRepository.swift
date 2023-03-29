//
//  DefaultPreferredCitiesRepository.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 22/03/2023.
//

import Foundation
import CoreData


final class DefaultPreferredCitiesRepository {

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PreferredCityModel")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
    func isCityAlreadyAddedToRepository(city: City) throws -> Bool {
        do {
            let preferredCities = try getPreferredCitiesFromRepository()
            return preferredCities.contains(city)
        } catch {
            throw IsCityAlreadyAddedUseCaseError.getPreferredCitiesUseCaseError
        }
    }
    
    func removeAllPreferredCitiesFromRepository() throws -> Void {
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PreferredCity")
        request.returnsObjectsAsFaults = false
        let results = try context.fetch(request)
        if !results.isEmpty {
            for result in results as! [NSManagedObject] {
                context.delete(result)
            }
        }
        do {
            try context.save()
        } catch {
            // TODO TO BE CHANGED TO DELETE USE CASE
            throw AddPreferredCityUseCaseError.coreDataSavingFailed
        }
    }
    
    func getPreferredCitiesFromRepository() throws -> Cities {
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PreferredCity")
        request.returnsObjectsAsFaults = false
        var cities: Cities = []
        let results = try context.fetch(request)
        if !results.isEmpty {
            for result in results as! [NSManagedObject] {
                    guard let name = result.value(forKey: "name") as? String else { throw GetPreferredCitiesUseCaseError.cityNameNotFound }
                    guard let lat = result.value(forKey: "lat") as? Double else { throw GetPreferredCitiesUseCaseError.cityLatNotFound }
                    guard let lon = result.value(forKey: "lon") as? Double else { throw GetPreferredCitiesUseCaseError.cityLonNotFound }
                    guard let country = result.value(forKey: "country") as? String else { throw GetPreferredCitiesUseCaseError.cityCountryNotFound }
                    guard let state = result.value(forKey: "state") as? String else { throw GetPreferredCitiesUseCaseError.cityStateNotFound }
                    let city = City(name: name, lat: lat, lon: lon, country: country, state: state)
                    cities.append(city)
                }
            }
        return cities
    }
    
    func savePreferredCityToRepository(city: City) throws {
        let context = persistentContainer.viewContext
        let newCity = NSEntityDescription.insertNewObject(forEntityName: "PreferredCity", into: context)
            newCity.setValue(city.name, forKey: "name")
            newCity.setValue(city.lat, forKey: "lat")
            newCity.setValue(city.lon, forKey: "lon")
            newCity.setValue(city.country, forKey: "country")
            newCity.setValue(city.state, forKey: "state")
        do {
            try context.save()
        } catch {
            throw AddPreferredCityUseCaseError.coreDataSavingFailed
        }
    }
}

extension DefaultPreferredCitiesRepository: PreferredCitiesRepository {

    func getPreferredCities() throws -> Cities {
        return try getPreferredCitiesFromRepository()
    }
    
    func savePreferredCity(city: City) throws {
        return try savePreferredCityToRepository(city: city)
    }
    
    func isCityAlreadyAddedToPreferred(city: City) throws -> Bool {
        return try isCityAlreadyAddedToRepository(city: city)
    }
}
