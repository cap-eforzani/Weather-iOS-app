//
//  DefaultImageRepository.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 28/03/2023.
//

import Foundation
import UIKit

final class DefaultImageRepository: ImageRepository {
    
    func getUIImage(image: ImageAvailableFromImageRepository) throws -> UIImage {
        switch image {
        case .preferred:
            if let image =  UIImage(named: "FavoriteOnIcon") {
                return image
            } else {
                throw GetUIImageFromImageRepositoryUseCaseError.imageNotFound
            }
        case .notPreferred:
            if let image =  UIImage(named: "FavoriteOffIcon") {
                return image
            } else {
                throw GetUIImageFromImageRepositoryUseCaseError.imageNotFound
            }
        case .delete:
            if let image =  UIImage(named: "DeleteIcon") {
                return image
            } else {
                throw GetUIImageFromImageRepositoryUseCaseError.imageNotFound
            }
        }
    }
}
