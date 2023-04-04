//
//  SettingsViewModel.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 03/04/2023.
//

import Foundation

struct SettingsViewModelActions {
    let navigateToPreviousView: () -> Void
}

protocol SettingsViewModelInput {
    func setShowLattitudeAndLongitudeSettingValue(value: Bool) -> Void
    func getShowLattitudeAndLongitudeSettingValue() -> Bool
    func didTapLattitudeAndLongitudeSwitch() -> Void
    func didTapNavigationBarBackButton() -> Void
}

protocol SettingsViewModelOutput {
    var screenTitle: String { get }
    var showLattitudeAndLongitude: Observable<Bool> { get }
}

typealias SettingsViewModel = SettingsViewModelInput & SettingsViewModelOutput

class DefaultSettingsViewModel : SettingsViewModel {
    
    let screenTitle = "Settings"
    
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
    
    func didTapNavigationBarBackButton() {
        actions?.navigateToPreviousView()
    }
    
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
