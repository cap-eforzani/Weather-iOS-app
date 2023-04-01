//
//  NavigationBar.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 31/03/2023.
//

import Foundation
import UIKit

extension UIViewController {
    
    func setDefaultNavigationBar(title: String, isBackButtonEnabled: Bool) {
        let actions = NavigationBarViewModelActions(didTapBackButton: navigateToPreviousView, didTapRightButton: navigateToSettingsView)
        let viewModel = DefaultNavigationBarViewModel(actions: actions, title: title)

        setNavigationBar(with: viewModel, isBackButtonEnabled: isBackButtonEnabled)
    }
    
    func setNavigationBar(with viewModel: NavigationBarViewModel, isBackButtonEnabled: Bool) {
        setBackgroundColor(color: viewModel.getBackgroundColor())
        if (isBackButtonEnabled == true) {
            setBackButton(button: viewModel.createBackButton())
        }
        setupTitle(label: viewModel.createTitle())
        setRightButton(button: viewModel.createSettingsButton())
    }
    
    func navigateToPreviousView() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func navigateToSettingsView() {
        print("navigateToSettingsView")
        // TODO
        // self.navigationController?.setViewControllers(<#T##viewControllers: [UIViewController]##[UIViewController]#>, animated: true)
    }
    
    private func setBackgroundColor(color: UIColor) {
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithOpaqueBackground()
        standardAppearance.backgroundColor = color
        
        let compactAppearance = standardAppearance.copy()

        let navBar = self.navigationController?.navigationBar
        navBar?.standardAppearance = standardAppearance
        navBar?.scrollEdgeAppearance = standardAppearance
        navBar?.compactAppearance = compactAppearance
    }
    
    func setBackButton(button: UIBarButtonItem) {
        self.navigationItem.leftBarButtonItem = button
    }
    
    func setRightButton(button: UIBarButtonItem) {
        self.navigationItem.rightBarButtonItem = button
    }
    
    func setupTitle(label: UILabel) {
        self.navigationItem.titleView = label
    }
}
