//
//  ImageRepository.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 28/03/2023.
//

import Foundation
import UIKit

protocol ImageRepository {
    func getUIImageForCityCell(isPreferred: Bool) throws -> UIImage
}
