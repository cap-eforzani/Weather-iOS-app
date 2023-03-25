//
//  UIViewExtensions.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 25/03/2023.
//

import Foundation
import UIKit

extension UIView {
    func round(_ radius: CGFloat = 10) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}
