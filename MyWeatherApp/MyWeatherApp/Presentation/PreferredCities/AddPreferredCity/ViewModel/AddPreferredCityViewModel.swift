//
//  AddPreferredCityViewModel.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 23/03/2023.
//

import Foundation

struct AddPreferredCityViewModelActions {
    let showPreferredCities: () -> Void
}

protocol AddPreferredCityViewModelInput {
    func searchCityByName(name: String) -> Void
}

typealias AddPreferredCityViewModel = AddPreferredCityViewModelInput

class DefaultAddPreferredCityViewModel : AddPreferredCityViewModel {
    
    private let addPreferredCityUseCase: AddPreferredCityUseCase
    private let actions: AddPreferredCityViewModelActions?
    
    init(addPreferredCityUseCase: AddPreferredCityUseCase, actions: AddPreferredCityViewModelActions? = nil) {
        self.addPreferredCityUseCase = addPreferredCityUseCase
        self.actions = actions
    }
}

extension DefaultAddPreferredCityViewModel {
    
    func searchCityByName(name: String) {
        print("SEARCH CITY")
        print(name)
    }
    
}
