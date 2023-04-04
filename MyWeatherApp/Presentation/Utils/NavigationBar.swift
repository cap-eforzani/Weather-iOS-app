//
//  NavigationBar.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 31/03/2023.
//

import Foundation
import UIKit

extension UIViewController {
    
    func setNavigationBar(backgroundColor: UIColor = .green, foregroundColor: UIColor = .black, title: String, isBackButtonEnabled: Bool, didTapBackButton: @escaping () -> Void = {}, isRightButtonEnabled: Bool, didTapRightButton: @escaping () -> Void = {}) {
        setNavigationBarBackgroundColor(color: backgroundColor)
        setNavigationBarTitle(title: title, foregroundColor: foregroundColor)
        if (isBackButtonEnabled == true) {
            setNavigationBarBackButton(foregroundColor: foregroundColor, didTapBackButton: didTapBackButton)
        }
        if (isRightButtonEnabled == true) {
            setNavigationBarRightButton(foregroundColor: foregroundColor, didTapRightButton: didTapRightButton)
        }
    }
    
    private func setNavigationBarBackgroundColor(color: UIColor) {
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithOpaqueBackground()
        standardAppearance.backgroundColor = color
        
        let compactAppearance = standardAppearance.copy()

        let navBar = self.navigationController?.navigationBar
        navBar?.standardAppearance = standardAppearance
        navBar?.scrollEdgeAppearance = standardAppearance
        navBar?.compactAppearance = compactAppearance
    }
    
    func setNavigationBarBackButton(foregroundColor: UIColor, didTapBackButton: @escaping () -> Void) {
        let backButton = UIButton(type: .system)
        let action = UIAction { action in
            didTapBackButton()
        }

        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.setTitle(" Back", for: .normal)
        backButton.sizeToFit()
        backButton.tintColor = foregroundColor
        backButton.addAction(action, for: .touchUpInside)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    func setNavigationBarRightButton(foregroundColor: UIColor, didTapRightButton: @escaping () -> Void) {
        let settingsButton = UIButton(type: .system)
        let action = UIAction { action in
            didTapRightButton()
        }

        settingsButton.setImage(UIImage(systemName: "gear"), for: .normal)
        settingsButton.sizeToFit()
        settingsButton.tintColor = foregroundColor
        settingsButton.addAction(action, for: .touchUpInside)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: settingsButton)
    }
    
    func setNavigationBarTitle(title: String, foregroundColor: UIColor) {
        let label = UILabel()
        
        label.autoresizingMask = .flexibleWidth
        label.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        label.font = UIFont(name: "EduNSWACTFoundation-Regular", size: 28)
        label.textColor = foregroundColor
        label.text = title
        
        self.navigationItem.titleView = label
    }
}
