//
//  FloatingButton.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 22/03/2023.
//

import Foundation
import UIKit

class FloatingButton {
    
    let button = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
    
    init(backgroundColor: UIColor, image: UIImage?) {
        button.backgroundColor = backgroundColor
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.3
        button.layer.cornerRadius = 30
    }
    
}
