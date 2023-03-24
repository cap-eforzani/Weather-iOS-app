//
//  AppDelegate.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 22/03/2023.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let appContainer = AppContainer()
    var appFlowCoordinator: AppFlowCoordinator?
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController(rootViewController: PreferredCitiesListViewController())

        window?.rootViewController = navigationController
        appFlowCoordinator = AppFlowCoordinator(navigationController: navigationController, appContainer: appContainer)
        appFlowCoordinator?.start()
        window?.makeKeyAndVisible()
        
        return true
    }
}

