//
//  ImageRepository.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 28/03/2023.
//

import Foundation
import UIKit

enum ImageAvailableFromImageRepository {
    case preferred
    case notPreferred
    case delete
}

protocol ImageRepository {
    func getImageData(image: ImageAvailableFromImageRepository) throws -> Data
}
