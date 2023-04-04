//
//  DefaultImageRepository.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 28/03/2023.
//

import Foundation
import UIKit

final class DefaultImageRepository: ImageRepository {
    
    func getImageData(image: ImageAvailableFromImageRepository) throws -> Data {
        switch image {
        case .preferred:
            if let image =  UIImage(named: "FavoriteOnIcon") {
                if let data: Data = image.pngData() {
                    return data
                } else {
                    throw GetImageDataFromImageRepositoryUseCaseError.cannotGetDataFromImage
                }
            } else {
                throw GetImageDataFromImageRepositoryUseCaseError.imageNotFound
            }
        case .notPreferred:
            if let image =  UIImage(named: "FavoriteOffIcon") {
                if let data: Data = image.pngData() {
                    return data
                } else {
                    throw GetImageDataFromImageRepositoryUseCaseError.cannotGetDataFromImage
                }
            } else {
                throw GetImageDataFromImageRepositoryUseCaseError.imageNotFound
            }
        case .delete:
            if let image =  UIImage(named: "DeleteIcon") {
                if let data: Data = image.pngData() {
                    return data
                } else {
                    throw GetImageDataFromImageRepositoryUseCaseError.cannotGetDataFromImage
                }
            } else {
                throw GetImageDataFromImageRepositoryUseCaseError.imageNotFound
            }
        }
    }
}
