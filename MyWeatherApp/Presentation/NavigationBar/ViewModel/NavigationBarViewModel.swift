//
//  NavigationBarViewModel.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 31/03/2023.
//

import Foundation
import UIKit

struct NavigationBarViewModelActions {
    let didTapBackButton: () -> Void
    let didTapRightButton: () -> Void
}

protocol NavigationBarViewModelInput {
    func createBackButton() -> UIBarButtonItem
    func createSettingsButton() -> UIBarButtonItem
    func createTitle() -> UILabel
    func getBackgroundColor() -> UIColor
}

protocol NavigationBarViewModelOutput {
}

typealias NavigationBarViewModel = NavigationBarViewModelInput & NavigationBarViewModelOutput

class DefaultNavigationBarViewModel : NavigationBarViewModel {
    
    private let title: String
    private let backgroundColor: UIColor
    private let foregroundColor: UIColor
    private let actions: NavigationBarViewModelActions?

    init(actions: NavigationBarViewModelActions? = nil, foregroundColor: UIColor = UIColor.black, backgroundColor: UIColor = UIColor.green, title: String) {
        self.actions = actions
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        self.title = title
    }
}

extension DefaultNavigationBarViewModel {
    
    func createBackButton() -> UIBarButtonItem {
        let backButton = UIButton(type: .system)
        let action = UIAction { action in
            self.actions?.didTapBackButton()
        }

        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.setTitle(" Back", for: .normal)
        backButton.sizeToFit()
        backButton.tintColor = foregroundColor
        backButton.addAction(action, for: .touchUpInside)
        
        return UIBarButtonItem(customView: backButton)
    }
    
    func createSettingsButton() -> UIBarButtonItem {
        let settingsButton = UIButton(type: .system)
        let action = UIAction { action in
            self.actions?.didTapRightButton()
        }

        settingsButton.setImage(UIImage(systemName: "gear"), for: .normal)
        settingsButton.sizeToFit()
        settingsButton.tintColor = foregroundColor
        settingsButton.addAction(action, for: .touchUpInside)
        
        return UIBarButtonItem(customView: settingsButton)
    }
    
    func createTitle() -> UILabel {
        let label = UILabel()
        
        label.autoresizingMask = .flexibleWidth
        label.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        label.font = UIFont(name: "EduNSWACTFoundation-Regular", size: 28)
        label.textColor = foregroundColor
        label.text = title
        
        return label
    }
    
    func getBackgroundColor() -> UIColor {
        return backgroundColor
    }
}
