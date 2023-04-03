//
//  SettingsViewModel.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 03/04/2023.
//

import Foundation

struct SettingsViewModelActions {
}

protocol SettingsViewModelInput {
    func setShowLattitudeAndLongitudeSettingValue(value: Bool) -> Void
    func getShowLattitudeAndLongitudeSettingValue() -> Bool
    func didTapLattitudeAndLongitudeSwitch() -> Void
}

protocol SettingsViewModelOutput {
    var showLattitudeAndLongitude: Observable<Bool> { get }
}

typealias SettingsViewModel = SettingsViewModelInput & SettingsViewModelOutput

class DefaultSettingsViewModel : SettingsViewModel {
    
    var showLattitudeAndLongitude: Observable<Bool> = Observable(false)
    
    private let getShowLattitudeAndLongitudeSettingUseCase: GetShowLattitudeAndLongitudeUseCase
    private let setShowLattitudeAndLongitudeSettingUseCase: SetShowLattitudeAndLongitudeUseCase
    
    private let actions: SettingsViewModelActions?
    
    init(getShowLattitudeAndLongitudeSettingUseCase: GetShowLattitudeAndLongitudeUseCase, setShowLattitudeAndLongitudeSettingUseCase: SetShowLattitudeAndLongitudeUseCase, actions: SettingsViewModelActions? = nil) {
        self.setShowLattitudeAndLongitudeSettingUseCase = setShowLattitudeAndLongitudeSettingUseCase
        self.getShowLattitudeAndLongitudeSettingUseCase = getShowLattitudeAndLongitudeSettingUseCase
        self.actions = actions
        initShowLattitudeAndLongitudeSettingValue()
    }
    
    private func initShowLattitudeAndLongitudeSettingValue() {
        showLattitudeAndLongitude.value = getShowLattitudeAndLongitudeSettingValue()
    }
}

extension DefaultSettingsViewModel {
    
    func setShowLattitudeAndLongitudeSettingValue(value: Bool) {
        showLattitudeAndLongitude.value = value
        setShowLattitudeAndLongitudeSettingUseCase.execute(value: value)
    }
    
    func getShowLattitudeAndLongitudeSettingValue() -> Bool {
        getShowLattitudeAndLongitudeSettingUseCase.execute()
    }
    
    func didTapLattitudeAndLongitudeSwitch() {
        setShowLattitudeAndLongitudeSettingUseCase.execute(value: !getShowLattitudeAndLongitudeSettingUseCase.execute())
    }
}
