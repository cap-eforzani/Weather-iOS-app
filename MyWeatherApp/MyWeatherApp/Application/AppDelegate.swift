//
//  AppDelegate.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 22/03/2023.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController(rootViewController: PreferredCitiesViewController())
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        self.window = window
        return true
    }
}

