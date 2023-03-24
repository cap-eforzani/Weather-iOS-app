//
//  AppFlowCoordinator.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 23/03/2023.
//

import Foundation
import UIKit

final class AppFlowCoordinator {
    
    var navigationController: UINavigationController
    private let appContainer: AppContainer
    
    init(navigationController: UINavigationController, appContainer: AppContainer) {
        self.navigationController = navigationController
        self.appContainer = appContainer
    }
    
    func start() {
        let preferredCitiesContainer = appContainer.makePreferredListContainer()
        let flow = preferredCitiesContainer.makePreferredCitiesFlowCoordinator(navigationController: navigationController)
        flow.start()
    }
}
