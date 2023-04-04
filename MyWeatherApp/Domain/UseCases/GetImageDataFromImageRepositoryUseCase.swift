//
//  GetImageDataFromImageRepositoryUseCase.swift
//  MyWeatherApp
//
//  Created by Enzo Forzani on 28/03/2023.
//

import Foundation
import UIKit

enum GetImageDataFromImageRepositoryUseCaseError: Error {
    case cannotGetDataFromImage
    case imageNotFound
}

protocol GetImageDataFromImageRepositoryUseCase {
    func execute(image: ImageAvailableFromImageRepository) throws -> Data
}

final class DefaultgetImageDataFromImageRepositoryUseCase : GetImageDataFromImageRepositoryUseCase {

    private let imageRepository: ImageRepository
    
    init(imageRepository: ImageRepository) {
        self.imageRepository = imageRepository
    }
    
    func execute(image: ImageAvailableFromImageRepository) throws -> Data {
        return try imageRepository.getImageData(image: image)
    }
}
